# Shadowsocks-libev for Docker

A mini docker image for Shadowsocks-libev only 15M in size.

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
