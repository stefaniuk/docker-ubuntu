FROM ubuntu:trusty-20160819
MAINTAINER daniel.stefaniuk@gmail.com

RUN apt-get --yes update \
    && apt-get --yes --ignore-missing --no-install-recommends install \
        ca-certificates \
        curl \
        net-tools \
        sudo \
        unzip \
        vim.tiny \
        wget \
    && rm -rf /var/lib/apt/lists/*
