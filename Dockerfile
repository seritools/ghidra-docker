FROM openjdk:15-jdk-slim

ENV VERSION 9.3_DEV
ENV GHIDRA_SHA 1328fa9fe8eb272ec966b8f1abc1ae4b5d380380afc0c330564b34e3e419d442

RUN apt-get update && apt-get install --no-install-recommends -y wget  unzip \
  && wget --progress=bar:force -O /tmp/ghidra.zip https://github.com/roblabla/ghidra-ci/releases/download/2020-12-31/release.zip \
  && echo "$GHIDRA_SHA /tmp/ghidra.zip" | sha256sum -c - \
  && unzip /tmp/ghidra.zip \
  && mv ghidra_${VERSION} /ghidra \
  && chmod +x /ghidra/ghidraRun \
  && apt-get purge -y --auto-remove wget unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/* /ghidra/docs \
  && rm -f /ghidra/server/server.conf \
  && ln -s /repos/server.conf /ghidra/server/server.conf

VOLUME [ "/repos" ]

EXPOSE 13100 13101 13102
ENTRYPOINT ["/ghidra/server/ghidraSvr", "console"]