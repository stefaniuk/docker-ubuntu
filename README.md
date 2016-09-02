[![CircleCI](https://circleci.com/gh/stefaniuk/docker-ubuntu.svg?style=shield "CircleCI")](https://circleci.com/gh/stefaniuk/docker-ubuntu) [![Quay](https://quay.io/repository/stefaniuk/ubuntu/status "Quay")](https://quay.io/repository/stefaniuk/ubuntu)[![MicroBadger](https://images.microbadger.com/badges/version/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu "MicroBadger")[![MicroBadger](https://images.microbadger.com/badges/image/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu "MicroBadger")[![MicroBadger](https://images.microbadger.com/badges/commit/stefaniuk/ubuntu.svg)](http://microbadger.com/images/stefaniuk/ubuntu "MicroBadger")

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
