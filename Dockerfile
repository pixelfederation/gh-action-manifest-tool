FROM debian:bullseye-slim

LABEL repository="https://github.com/pixelfederation/gh-action-manifest"
LABEL maintainer="Tomas Hulata<thulata@pixelfederation.com>"

ARG MANIFEST_TOOL_VERSION=2.1.6
ARG MANIFEST_TOOL_SHA256=585b1e9a78912d99590cf769cfa9b42348a920453d06f37b42f07078c0abc0ad

RUN apt update -y && \
    apt install --no-install-recommends -y amazon-ecr-credential-helper wget && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/sh", "-c"]

COPY entrypoint.sh arch.sh /

RUN . /arch.sh && mkdir -p /tmp/tool && \
    wget -O /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz && \
    echo "${MANIFEST_TOOL_SHA256}  /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz" | sha256sum -c && \
    tar -xvzf /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz -C /tmp/tool/ && cp /tmp/tool/manifest-tool-${OS}-${ARCH} /bin/manifest-tool && \
    rm -rf /tmp/* && chmod +x /bin/manifest-tool /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
