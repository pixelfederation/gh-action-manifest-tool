FROM debian:bullseye-slim

LABEL repository="https://github.com/pixelfederation/gh-action-manifest"
LABEL maintainer="Tomas Hulata<thulata@pixelfederation.com>"

ARG MANIFEST_TOOL_VERSION=2.0.3
ARG MANIFEST_TOOL_SHA256=78971079cc0d8eddd90751fe6d8bf9b10ecf73a5476103d3673bf39b5da961d3

RUN apt update -y && \
    apt install --no-install-recommends -y amazon-ecr-credential-helper wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.docker
ADD config.json ~/.docker/

SHELL ["/bin/sh", "-c"]

COPY entrypoint.sh arch.sh /

RUN . /arch.sh && mkdir -p /tmp/tool && \
    wget -O /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_TOOL_VERSION}/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz && \
    echo "${MANIFEST_TOOL_SHA256}  /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz" | sha256sum -c && \
    tar -xvzf /tmp/binaries-manifest-tool-${MANIFEST_TOOL_VERSION}.tar.gz -C /tmp/tool/ && cp /tmp/tool/manifest-tool-${OS}-${ARCH} /bin/manifest-tool && \
    rm -rf /tmp/* && chmod +x /bin/manifest-tool /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
