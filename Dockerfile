FROM alpine

MAINTAINER Secbone <secbone@gmail.com>

ENV SS_VERSION 3.0.7
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VERSION.tar.gz
ENV SS_PORT 8388

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                curl \
                                libev-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp && \
    curl -sSL $SS_URL | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd .. && \

    runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/*

ADD config.json /conf/shadowsocks.json

EXPOSE $SS_PORT/tcp $SS_PORT/udp

ENTRYPOINT ss-server -u -c /conf/shadowsocks.json -p $SS_PORT
