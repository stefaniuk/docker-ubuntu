FROM ubuntu:16.04
MAINTAINER daniel.stefaniuk@gmail.com
# SEE: https://github.com/tianon/gosu

ENV SYSTEM_USER="user" \
    GOSU_VERSION="1.9" \
    GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download" \
    GOSU_GPG_KEY="B42F6819007F00F88E364FD4036A9C25BF357DD4"

RUN set -ex \
    \
    echo "APT::Install-Recommends 0;\nAPT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
    && apt-get --yes update \
    && apt-get --yes install \
        ca-certificates \
        curl \
        net-tools \
        netcat \
        unzip \
        vim.tiny \
        wget \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* \
    \
    && arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch" \
    && wget -O /usr/local/bin/gosu.asc "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys $GOSU_GPG_KEY \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    \
    && groupadd --system $SYSTEM_USER \
    && useradd --system --gid $SYSTEM_USER $SYSTEM_USER

COPY assets/sbin/entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
