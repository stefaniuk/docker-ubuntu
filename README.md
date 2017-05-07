[![Circle CI](https://circleci.com/gh/codeworksio/docker-ubuntu.svg?style=shield "CircleCI")](https://circleci.com/gh/codeworksio/docker-ubuntu)&nbsp;[![Size](https://images.microbadger.com/badges/image/codeworksio/ubuntu.svg)](http://microbadger.com/images/codeworksio/ubuntu)&nbsp;[![Version](https://images.microbadger.com/badges/version/codeworksio/ubuntu.svg)](http://microbadger.com/images/codeworksio/ubuntu)&nbsp;[![Commit](https://images.microbadger.com/badges/commit/codeworksio/ubuntu.svg)](http://microbadger.com/images/codeworksio/ubuntu)&nbsp;[![Docker Hub](https://img.shields.io/docker/pulls/codeworksio/ubuntu.svg)](https://hub.docker.com/r/codeworksio/ubuntu/)

Docker Ubuntu
=============

Customised Ubuntu base image.

Installation
------------

Builds of the image are available on [Docker Hub](https://hub.docker.com/r/codeworksio/ubuntu/).

    docker pull codeworksio/ubuntu

Alternatively you can build the image yourself.

    docker build --tag codeworksio/ubuntu \
        github.com/codeworksio/docker-ubuntu

Configuration
-------------

- `/sbin/entrypoint.sh` is defined as the entrypoint
- `/sbin/bootstrap.sh` is sourced if present
- `/sbin/init.d/*.sh` are sourced if present
- Set `INIT_DEBUG=true` to enable verbose output
- Set `INIT_TRACE=true` to pass the main process to `strace` (use along with `--privileged`)
- Set `INIT_RUN_AS=root` to start the main process as a privileged user
- Set `INIT_GOSU=true` to make use of `gosu` (default)
- Use `--privileged` flag to give extended privileges to this container
- Use `--cap-add` and `--cap-drop` to control Linux kernel capabilities

Testing
-------

    make build start bash
