FROM alpine:edge
MAINTAINER Yu Jin <im@yjin.dev>

ENV LANG C.UTF-8

RUN apk add --update --no-cache ca-certificates

RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
                git \
                ffmpeg \
                libmagic \
                libwebp \
                python3 \
                tiff \
                freetype \
                lcms2 \
                openjpeg \
                openblas \
                py3-pip \
                py3-olefile \
                py3-numpy \
                py3-pillow \
                py3-yaml \
                py3-cryptography \
                py3-decorator \
                jpeg-dev \
                zlib-dev \
                cairo

RUN set -ex \
        && pip3 install --upgrade pip \
        && pip3 install ehforwarderbot \
        && pip3 install efb-telegram-master \
        && pip3 install efb-wechat-slave \
        && pip3 install python-telegram-bot --upgrade

# middlewares
RUN mkdir -p /root/.ehforwarderbot/modules/
RUN wget https://gist.githubusercontent.com/blueset/0084ab142e2213bca50d81d08753e564/raw/8699f4b7007b396ff06493eb3ded34402b19d5d0/filter.py -P /root/.ehforwarderbot/modules/

RUN mkdir -p /usr/local/src
RUN cd /usr/local/src && \
    git clone https://github.com/catbaron0/efb-sticker2img-middleware && \
    cd efb-sticker2img-middleware && \
    python3 setup.py install

WORKDIR /root/.ehforwarderbot/profiles/default/
CMD ["ehforwarderbot"]
