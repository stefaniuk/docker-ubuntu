FROM ubuntu:xenial-20161010
MAINTAINER daniel.stefaniuk@gmail.com

ARG APT_PROXY
ARG APT_PROXY_SSL
ENV TZ="Europe/London" \
    LANG="en_GB.UTF-8" \
    LC_ALL="en_GB.UTF-8" \
    SYSTEM_USER="default" \
    SYSTEM_USER_UID="1000" \
    SYSTEM_USER_GID="1000" \
    GOSU_VERSION="1.10" \
    GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download" \
    GOSU_GPG_KEY="B42F6819007F00F88E364FD4036A9C25BF357DD4" \
    RUN_AS=""

RUN set -ex \
    \
    && if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"http://${APT_PROXY}\"; };" > /etc/apt/apt.conf.d/00proxy; fi \
    && if [ -n "$APT_PROXY_SSL" ]; then echo "Acquire::https { Proxy \"https://${APT_PROXY_SSL}\"; };" > /etc/apt/apt.conf.d/00proxy; fi \
    && echo "APT::Install-Recommends 0;\nAPT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
    && apt-get --yes update \
    && apt-get --yes upgrade \
    && apt-get --yes install \
        ca-certificates \
        curl \
        dnsutils \
        iputils-ping \
        lsof \
        net-tools \
        netcat \
        strace \
        unzip \
        vim.tiny \
        wget \
    \
    && locale-gen $LANG \
    && groupadd --system --gid $SYSTEM_USER_GID $SYSTEM_USER \
    && useradd --system --create-home --uid $SYSTEM_USER_UID --gid $SYSTEM_USER_GID $SYSTEM_USER \
    \
    # SEE: https://github.com/tianon/gosu
    && arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && curl -L "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch" -o /usr/local/bin/gosu \
    && curl -L "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-$arch.asc" -o /usr/local/bin/gosu.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys $GOSU_GPG_KEY \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    \
    # SEE: https://github.com/stefaniuk/dotfiles
    && curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s -- \
        --config=bash \
        --minimal \
    \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* \
    && rm -f /etc/apt/apt.conf.d/00proxy

COPY assets/sbin/entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]

### METADATA ###################################################################

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
LABEL \
    version=$VERSION \
    build-date=$BUILD_DATE \
    vcs-ref=$VCS_REF \
    vcs-url=$VCS_URL \
    license="MIT"
