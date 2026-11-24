# ゲートtlsfuzzの自前の会話（tlsfuzzerのライブラリで書く。tlsfuzzerの本体には無い形）:
# early_dataつきのClientHelloと0-RTTのデータ（外側の型がapplication_dataのrecord。本体は乱数）を続けて送る。サーバーは0-RTTを断るHelloRetryRequest
# （key_shareを送り済みなのでkey_shareは求めず、cookieを入れる）を返し、0-RTTのデータを復号せずに、本体の合計が2 × (2^14 + 256) = 33,280バイトまで読み飛ばす
# （RFC 9846 4.3.10の2つ目の方法）。上限の内（2^14バイトのrecordを2つ）なら、cookieを返した2番目のClientHelloでhandshakeが済み、リクエストに応える。
# 上限を越えたら（2^14バイトのrecordを3つ）unexpected_messageで閉じる（4.7.1）。
# 出力の形はtlsfuzzerのスクリプトと同じ（TOTAL・FAILEDの一覧）。引数: -h ホスト -p ポート
import getopt
import os
import sys
import traceback

sys.path[:0] = [os.path.dirname(os.path.dirname(os.path.abspath(__file__)))]

from tlsfuzzer.runner import Runner
from tlsfuzzer.messages import Connect, ClientHelloGenerator, FinishedGenerator, \
    ApplicationDataGenerator, AlertGenerator, TCPBufferingEnable, TCPBufferingDisable, TCPBufferingFlush, \
    SetRecordVersion, ch_cookie_handler
from tlsfuzzer.expect import ExpectServerHello, ExpectChangeCipherSpec, ExpectEncryptedExtensions, \
    ExpectCertificate, ExpectCertificateVerify, ExpectFinished, ExpectApplicationData, ExpectAlert, ExpectClose, \
    ExpectHelloRetryRequest
from tlslite.constants import CipherSuite, AlertLevel, AlertDescription, TLS_1_3_DRAFT, GroupName, \
    ExtensionType, SignatureScheme, PskKeyExchangeMode
from tlslite.extensions import ClientKeyShareExtension, SupportedVersionsExtension, SupportedGroupsExtension, \
    SignatureAlgorithmsExtension, SignatureAlgorithmsCertExtension, PskKeyExchangeModesExtension, \
    PreSharedKeyExtension, PskIdentity, TLSExtension
from tlslite.utils.cryptomath import getRandomNumber, getRandomBytes
from tlsfuzzer.helpers import key_share_gen, RSA_SIG_ALL
from tlsfuzzer.utils.ordered_dict import OrderedDict


REQ = bytearray(b"GET / HTTP/1.1\r\nHost: localhost\r\n\r\n")


def exts(share, iden, early, cookie):
    groups = [GroupName.x25519]
    ext = OrderedDict()
    ext[ExtensionType.key_share] = ClientKeyShareExtension().create([share])
    ext[ExtensionType.supported_versions] = SupportedVersionsExtension().create([TLS_1_3_DRAFT, (3, 3)])
    ext[ExtensionType.supported_groups] = SupportedGroupsExtension().create(groups)
    ext[ExtensionType.signature_algorithms] = SignatureAlgorithmsExtension().create(
        [SignatureScheme.rsa_pss_rsae_sha256, SignatureScheme.rsa_pss_pss_sha256])
    ext[ExtensionType.signature_algorithms_cert] = SignatureAlgorithmsCertExtension().create(RSA_SIG_ALL)
    if early:
        ext[ExtensionType.early_data] = TLSExtension(extType=ExtensionType.early_data)
    if cookie:
        ext[ExtensionType.cookie] = ch_cookie_handler
    ext[ExtensionType.psk_key_exchange_modes] = PskKeyExchangeModesExtension().create(
        [PskKeyExchangeMode.psk_dhe_ke, PskKeyExchangeMode.psk_ke])
    # 前の実装が出したチケットの代わり（サーバーは読まない）。pre_shared_keyは最後の拡張
    ext[ExtensionType.pre_shared_key] = PreSharedKeyExtension().create([iden], [getRandomBytes(32)])
    return ext


def early(host, port, records):
    conversation = Connect(host, port)
    node = conversation
    ciphers = [CipherSuite.TLS_AES_128_GCM_SHA256]
    share = key_share_gen(GroupName.x25519)
    iden = PskIdentity().create(getRandomBytes(320), getRandomNumber(2**30, 2**32))
    node = node.add_child(TCPBufferingEnable())
    node = node.add_child(ClientHelloGenerator(ciphers, extensions=exts(share, iden, True, False)))
    node = node.add_child(SetRecordVersion((3, 3)))
    for _ in range(records):
        node = node.add_child(ApplicationDataGenerator(getRandomBytes(2**14)))
    node = node.add_child(TCPBufferingDisable())
    node = node.add_child(TCPBufferingFlush())
    node = node.add_child(ExpectHelloRetryRequest(extensions={ExtensionType.cookie: None, ExtensionType.supported_versions: None}))
    node = node.add_child(ExpectChangeCipherSpec())
    return conversation, node, ciphers, share, iden


def main():
    host, port = "localhost", 4433
    opts, _ = getopt.getopt(sys.argv[1:], "h:p:")
    for opt, arg in opts:
        if opt == '-h':
            host = arg
        elif opt == '-p':
            port = int(arg)
    conversations = {}

    # 上限の内: 2^14バイトのrecordを2つ読み飛ばし、cookieつきの2番目のClientHelloで続ける
    conversation, node, ciphers, share, iden = early(host, port, 2)
    node = node.add_child(ClientHelloGenerator(ciphers, extensions=exts(share, iden, False, True)))
    for e in [ExpectServerHello(), ExpectEncryptedExtensions(), ExpectCertificate(), ExpectCertificateVerify(), ExpectFinished()]:
        node = node.add_child(e)
    node = node.add_child(FinishedGenerator())
    node = node.add_child(ApplicationDataGenerator(REQ))
    node = node.add_child(ExpectApplicationData())
    node = node.add_child(AlertGenerator(AlertLevel.warning, AlertDescription.close_notify))
    node = node.add_child(ExpectAlert(AlertLevel.warning, AlertDescription.close_notify))
    node = node.add_child(ExpectClose())
    conversations["early data within the skip limit, then 2nd ClientHello with cookie"] = conversation

    # 上限を越える: 2^14バイトのrecordを3つ（49,152バイト > 33,280バイト）
    conversation, node, ciphers, share, iden = early(host, port, 3)
    node = node.add_child(ExpectAlert(AlertLevel.fatal, AlertDescription.unexpected_message))
    node = node.add_child(ExpectClose())
    conversations["early data over the skip limit"] = conversation

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
