[![Circle CI](https://circleci.com/gh/stefaniuk/docker-ubuntu.svg?style=shield "CircleCI")](https://circleci.com/gh/stefaniuk/docker-ubuntu)&nbsp;[![Size](https://images.microbadger.com/badges/image/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu)&nbsp;[![Version](https://images.microbadger.com/badges/version/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu)&nbsp;[![Commit](https://images.microbadger.com/badges/commit/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu)&nbsp;[![Docker Registry](https://img.shields.io/docker/pulls/stefaniuk/ubuntu.svg)](https://registry.hub.docker.com/u/jumanjiman/aws)

Docker Ubuntu
=============

My customised Ubuntu baseimage.

Installation
------------

Builds of the image are available on [Docker Hub](https://hub.docker.com/r/stefaniuk/ubuntu/).

    docker pull stefaniuk/ubuntu:latest

Alternatively you can build the image yourself.

    docker build --tag stefaniuk/ubuntu \
        github.com/stefaniuk/docker-ubuntu
