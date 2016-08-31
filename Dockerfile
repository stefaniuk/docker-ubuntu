FROM ubuntu:16.04
MAINTAINER daniel.stefaniuk@gmail.com

ARG APT_PROXY
ENV SYSTEM_USER="default" \
    SYSTEM_USER_UID="1000" \
    SYSTEM_USER_GID="1000" \
    GOSU_VERSION="1.9" \
    GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download" \
    GOSU_GPG_KEY="B42F6819007F00F88E364FD4036A9C25BF357DD4"

RUN set -ex \
    \
    && echo "APT::Install-Recommends 0;\nAPT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
    && if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"$APT_PROXY\"; };" >> /etc/apt/apt.conf.d/00proxy; fi \
    && apt-get --yes update \
    && apt-get --yes install \
        ca-certificates \
        curl \
        lsof \
        net-tools \
        netcat \
        strace \
        unzip \
        vim.tiny \
        wget \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* \
    && rm -f /etc/apt/apt.conf.d/00proxy \
    \
    # SEE: https://github.com/tianon/gosu
    && arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch" \
    && wget -O /usr/local/bin/gosu.asc "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys $GOSU_GPG_KEY \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    \
    && groupadd --system --gid $SYSTEM_USER_GID $SYSTEM_USER \
    && useradd --system --no-create-home --uid $SYSTEM_USER_UID --gid $SYSTEM_USER_GID $SYSTEM_USER

COPY assets/sbin/entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
