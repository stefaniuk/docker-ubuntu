FROM ubuntu:trusty-20160819
MAINTAINER daniel.stefaniuk@gmail.com

RUN echo "APT::Install-Recommends 0;\nAPT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends \
    && apt-get --yes update \
    && apt-get --yes install \
        ca-certificates \
        curl \
        net-tools \
        netcat \
        sudo \
        unzip \
        vim.tiny \
        wget \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
