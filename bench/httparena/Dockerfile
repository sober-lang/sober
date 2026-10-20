# Dockerfile — HttpArena の本家の形（ソースから建てる — frameworks/sober/ に置く）。
# TODO（0.6.0 の公開リリースの後 — std/http を含む版）: 下の SOBER_VERSION のリリースの tarball（静的 ELF の sober — std は焼き込み）を取り、
# main.sober を建てる。それまでは Dockerfile.local（手元で建てた ELF を COPY）で計測する — 本家への参戦は 0.6.0 の話（report-671）
FROM alpine:3.20 AS build
ARG SOBER_VERSION=0.6.0
RUN apk add --no-cache curl tar
# 資産名は v0.5.4 の Release CI の形（sober-v<版>-x86_64-linux.tar.gz — 中身は sober の静的 ELF 1 本〔std は焼き込み〕と LICENSE / README）
RUN curl -fsSL "https://github.com/sober-lang/sober/releases/download/v${SOBER_VERSION}/sober-v${SOBER_VERSION}-x86_64-linux.tar.gz" | tar -xz -C /opt
WORKDIR /app
COPY main.sober ./
RUN /opt/sober-v${SOBER_VERSION}-x86_64-linux/sober build main.sober -o server

FROM scratch
COPY --from=build /app/server /server
EXPOSE 8080
CMD ["/server"]
