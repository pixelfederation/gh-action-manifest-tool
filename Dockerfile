FROM alpine:3.15.0
ARG MANIFEST_TOOL_VERSION=2.0.0

SHELL ["/bin/sh", "-c"]


RUN mkdir -p /tmp/tool && \
    wget -O /tmp/tool/manifest-tool.tgz \
    https://github.com/estesp/manifest-tool/releases/download/v2.0.0/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz && \
    cd /tmp/tool/ && tar -xvzf manifest-tool.tgz


COPY entrypoint.sh /
COPY arch.sh /

RUN . /arch.sh && \
    cp /tmp/tool/manifest-tool* /bin/ && \
    cp /tmp/tool/manifest-tool-${OS}-${ARCH} /bin/manifest-tool && \
    chmod +x /bin/manifest-tool* && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

LABEL repository="https://github.com/pixelfederation/gh-action-manifest" \
    maintainer="Tomas Hulata<thulata@pixelederation.com>"
