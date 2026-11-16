# ゲートtlsfuzzの自前の会話（tlsfuzzerのライブラリで書く。tlsfuzzerの本体には無い形）:
# HTTP/1.1のリクエスト（keep-alive）の後に、長すぎるrecordを送る。keep-aliveのレスポンスは、std/httpのServeWithが積んで（put）次の受けへ進む経路を通る。
# サーバーは、レスポンスを送り終えてから、record_overflowのalertを送って閉じなければならない（alertがレスポンスの前に出たり、alertを送らずに閉じたりしない。RFC 9846 5.2・6.2）。
# 出力の形はtlsfuzzerのスクリプトと同じ（TOTAL・FAILEDの一覧）。引数: -h ホスト -p ポート
import getopt
import os
import sys
import traceback

sys.path[:0] = [os.path.dirname(os.path.dirname(os.path.abspath(__file__)))]

from tlsfuzzer.runner import Runner
from tlsfuzzer.messages import Connect, ClientHelloGenerator, FinishedGenerator, \
    ApplicationDataGenerator, TCPBufferingEnable, TCPBufferingDisable, TCPBufferingFlush, SetMaxRecordSize
from tlsfuzzer.expect import ExpectServerHello, ExpectChangeCipherSpec, ExpectEncryptedExtensions, \
    ExpectCertificate, ExpectCertificateVerify, ExpectFinished, ExpectApplicationData, ExpectAlert, ExpectClose
from tlslite.constants import CipherSuite, AlertLevel, AlertDescription, TLS_1_3_DRAFT, GroupName, \
    ExtensionType, SignatureScheme
from tlslite.extensions import ClientKeyShareExtension, SupportedVersionsExtension, SupportedGroupsExtension, \
    SignatureAlgorithmsExtension, SignatureAlgorithmsCertExtension
from tlsfuzzer.helpers import key_share_gen, RSA_SIG_ALL


REQ = bytearray(b"GET / HTTP/1.1\r\nHost: localhost\r\n\r\n")


def hello(host, port):
    conversation = Connect(host, port)
    node = conversation
    groups = [GroupName.x25519]
    ext = {
        ExtensionType.key_share: ClientKeyShareExtension().create([key_share_gen(g) for g in groups]),
        ExtensionType.supported_versions: SupportedVersionsExtension().create([TLS_1_3_DRAFT, (3, 3)]),
        ExtensionType.supported_groups: SupportedGroupsExtension().create(groups),
        ExtensionType.signature_algorithms: SignatureAlgorithmsExtension().create(
            [SignatureScheme.rsa_pss_rsae_sha256, SignatureScheme.rsa_pss_pss_sha256]),
        ExtensionType.signature_algorithms_cert: SignatureAlgorithmsCertExtension().create(RSA_SIG_ALL),
    }
    node = node.add_child(ClientHelloGenerator([CipherSuite.TLS_AES_128_GCM_SHA256], extensions=ext))
    for e in [ExpectServerHello(), ExpectChangeCipherSpec(), ExpectEncryptedExtensions(), ExpectCertificate(),
              ExpectCertificateVerify(), ExpectFinished()]:
        node = node.add_child(e)
    node = node.add_child(FinishedGenerator())
    return conversation, node


def main():
    host, port = "localhost", 4433
    opts, _ = getopt.getopt(sys.argv[1:], "h:p:")
    for opt, arg in opts:
        if opt == '-h':
            host = arg
        elif opt == '-p':
            port = int(arg)
    conversations = {}
    big = bytearray(2 ** 14 + 1)

    # レスポンスを受けてから（Recvの中の送りが完了を待たずに戻った後に）長すぎるrecord
    conversation, node = hello(host, port)
    node = node.add_child(ApplicationDataGenerator(REQ))
    node = node.add_child(ExpectApplicationData())
    node = node.add_child(SetMaxRecordSize(2 ** 16 - 1))
    node = node.add_child(ApplicationDataGenerator(big))
    node = node.add_child(ExpectAlert(AlertLevel.fatal, AlertDescription.record_overflow))
    node = node.add_child(ExpectClose())
    conversations["record_overflow after a kept-alive response"] = conversation

    # リクエストと長すぎるrecordを1つの書き込みで（レスポンスを積んだまま誤りに当たる）
    conversation, node = hello(host, port)
    node = node.add_child(TCPBufferingEnable())
    node = node.add_child(ApplicationDataGenerator(REQ))
    node = node.add_child(SetMaxRecordSize(2 ** 16 - 1))
    node = node.add_child(ApplicationDataGenerator(big))
    node = node.add_child(TCPBufferingDisable())
    node = node.add_child(TCPBufferingFlush())
    node = node.add_child(ExpectApplicationData())
    node = node.add_child(ExpectAlert(AlertLevel.fatal, AlertDescription.record_overflow))
    node = node.add_child(ExpectClose())
    conversations["request and record_overflow in one write"] = conversation

    failed = []
    for name, conv in conversations.items():
        print("{0} ...".format(name))
        try:
            Runner(conv).run()
            print("OK\n")
        except Exception:
            print("Error while processing")
            print(traceback.format_exc())
            failed.append(name)
    print("TOTAL: {0}".format(len(conversations)))
    print("PASS: {0}".format(len(conversations) - len(failed)))
    print("FAIL: {0}".format(len(failed)))
    if failed:
        print("FAILED:\n\t{0}".format('\n\t'.join(repr(i) for i in failed)))
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
