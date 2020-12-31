FROM openjdk:15-jdk-slim

ENV VERSION 9.2.1_PUBLIC
ENV GHIDRA_SHA cfaeb2b5938dec90388e936f63600ad345d41b509ffed4727142ba9ed44cb5e8

RUN apt-get update && apt-get install --no-install-recommends -y wget  unzip \
  && wget --progress=bar:force -O /tmp/ghidra.zip https://ghidra-sre.org/ghidra_9.2.1_PUBLIC_20201215.zip \
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