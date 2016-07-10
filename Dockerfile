FROM debian:latest

MAINTAINER Secbone <secbone@gmail.com>

ENV DEPENDENCIES build-essential autoconf libtool libssl-dev git-core
ENV NORECOMMENDS asciidoc xmlto
ENV BASEDIR /tmp/shadowsocks-libev

EXPOSE 8388

# Set up building environment
RUN apt-get update
RUN apt-get install -y $DEPENDENCIES
RUN apt-get install -y $NORECOMMENDS --no-install-recommends

# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git $BASEDIR
WORKDIR $BASEDIR
RUN ./configure
RUN make -j4
RUN make install

WORKDIR /etc/init.d

# Tear down building environment and delete git repository
RUN rm -rf $BASEDIR
RUN apt-get --purge autoremove -y $DEPENDENCIES $NORECOMMENDS

ADD config.json /conf/shadowsocks.json

ENTRYPOINT ss-server -u -c /conf/shadowsocks.json -p 8388
