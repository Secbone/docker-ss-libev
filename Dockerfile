FROM alpine

MAINTAINER Secbone <secbone@gmail.com>

ENV SS_VERSION 3.0.3
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VERSION.tar.gz
ENV SS_DIR shadowsocks-libev-$SS_VERSION
ENV SS_DEPENDENCE pcre
ENV SS_BUILD make gcc libc-dev autoconf libtool linux-headers asciidoc xmlto curl pcre-dev
ENV SS_PORT 8388

RUN apk --no-cache add $SS_DEPENDENCE $SS_BUILD && \
    curl -L $SS_URL | tar -zxv && \
    cd $SS_DIR && \
    ./configure && \
    make install && \
    cd .. && \
    rm -rf $SS_DIR && \
    apk del --purge $SS_BUILD

ADD config.json /conf/shadowsocks.json

EXPOSE $SS_PORT

ENTRYPOINT ss-server -u -c /conf/shadowsocks.json -p $SS_PORT
