FROM alpine:latest

MAINTAINER Secbone <secbone@gmail.com>

EXPOSE 8388

# Set up building environment
RUN apk --no-cache add --virtual build-dep make gcc libc-dev linux-headers autoconf libtool openssl-dev git asciidoc xmlto && \
    git clone https://github.com/shadowsocks/shadowsocks-libev.git /tmp/shadowsocks-libev && \
    cd /tmp/shadowsocks-libev && \
    ./configure && \
    make -j4 && \
    make install && \
    cd /etc/init.d && \
    rm -rf /tmp/shadowsocks-libev && \
    apk del build-dep


ADD config.json /conf/shadowsocks.json

ENTRYPOINT ss-server -u -c /conf/shadowsocks.json -p 8388
