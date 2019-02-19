FROM ubuntu:bionic-20190204

ARG APT_PROXY
ARG APT_PROXY_SSL
ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    SYSTEM_USER="default" \
    SYSTEM_USER_UID="1000" \
    SYSTEM_USER_GID="1000" \
    INIT_DEBUG="false" \
    INIT_TRACE="false" \
    INIT_GOSU="true" \
    INIT_RUN_AS=""

RUN set -ex && \
    \
    # install system packages
    if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"http://${APT_PROXY}\"; };" > /etc/apt/apt.conf.d/00proxy; fi && \
    if [ -n "$APT_PROXY_SSL" ]; then echo "Acquire::https { Proxy \"https://${APT_PROXY_SSL}\"; };" > /etc/apt/apt.conf.d/00proxy; fi && \
    echo "APT::Install-Recommends 0;\nAPT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends && \
    apt-get --yes update && \
    apt-get --yes upgrade && \
    apt-get --yes install \
        ca-certificates \
        curl \
        dirmngr \
        gnupg \
    && \
    # SEE: https://github.com/tianon/gosu
    GOSU_VERSION="1.11" && \
    GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download" && \
    curl -L "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-amd64" -o /bin/gosu && \
    curl -L "$GOSU_DOWNLOAD_URL/$GOSU_VERSION/gosu-amd64.asc" -o /tmp/gosu.asc && \
    gpg --keyserver "hkp://p80.pool.sks-keyservers.net:80" --recv-keys "B42F6819007F00F88E364FD4036A9C25BF357DD4" && \
    gpg --verify /tmp/gosu.asc /bin/gosu && \
    chmod +x /bin/gosu && \
    gosu nobody true && \
    \
    # SEE: https://github.com/stefaniuk/dotfiles
    curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/dotfiles -o - | /bin/bash -s -- \
        --minimal \
    && \
    # configure system user
    groupadd --system --gid $SYSTEM_USER_GID $SYSTEM_USER && \
    useradd --system --create-home --uid $SYSTEM_USER_UID --gid $SYSTEM_USER_GID $SYSTEM_USER && \
    \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* && \
    rm -f /etc/apt/apt.conf.d/00proxy

COPY assets/ /

ENTRYPOINT [ "/sbin/entrypoint.sh" ]

### METADATA ###################################################################

ARG IMAGE
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF
ARG VCS_URL
LABEL \
    org.label-schema.name=$IMAGE \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.schema-version="1.0"
