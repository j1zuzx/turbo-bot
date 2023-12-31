FROM        --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

LABEL       author="j1zuz" maintainer="hackw.tech"

RUN         apt update \
            && apt -y upgrade \
            && apt -y install imagemagick ffmpeg nodejs iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping libnss3 tini \
            && ffmpeg -version \
            && useradd -m -d /home/container container

RUN         npm install npm@latest typescript ts-node @types/node --location=global

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]