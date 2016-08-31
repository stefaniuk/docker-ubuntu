[![CircleCI](https://circleci.com/gh/stefaniuk/docker-ubuntu.svg?style=shield "CircleCI")](https://circleci.com/gh/stefaniuk/docker-ubuntu) [![Quay](https://quay.io/repository/stefaniuk/ubuntu/status "Quay")](https://quay.io/repository/stefaniuk/ubuntu)

Docker Ubuntu
=============

My customised Ubuntu baseimage.

Installation
------------

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/stefaniuk/ubuntu/).

    docker pull stefaniuk/ubuntu

Alternatively you can build the image yourself.

    docker build --tag stefaniuk/ubuntu \
        github.com/stefaniuk/docker-ubuntu
