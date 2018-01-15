# Shadowsocks-libev for Docker

[![Docker build][build-image]][hub-url]
[![Docker pulls][pulls-image]][hub-url]
[![Docker stars][stars-image]][hub-url]
[![Docker size][size-image]][size-url]

A mini docker image of [Shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) only 15M in size.

## Tags

- `2.4.6`
- ...
- `3.1.0`
- `3.1.1`
- `3.1.2`, `latest`

## Usage

```
docker pull secbone/docker-ss-libev
```

```
docker run -d -p 8388:8388 secbone/docker-ss-libev

# custom config
docker run -d -v /path/to/config.json:/conf/shadowsocks.json -p <yourport>:8388 secbone/docker-ss-libev
```

## default config

- port: `8388`
- password: `iachshea`
- timeout: `60`
- method: `aes-256-cfb`

[pulls-image]: https://img.shields.io/docker/pulls/secbone/docker-ss-libev.svg?style=flat-square
[hub-url]: https://hub.docker.com/r/secbone/docker-ss-libev/
[stars-image]: https://img.shields.io/docker/stars/secbone/docker-ss-libev.svg?style=flat-square
[size-image]: https://images.microbadger.com/badges/image/secbone/docker-ss-libev.svg
[size-url]: https://microbadger.com/images/secbone/docker-ss-libev
[build-image]: https://img.shields.io/docker/build/secbone/docker-ss-libev.svg?style=flat-square
