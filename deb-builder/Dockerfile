FROM ubuntu:xenial

LABEL name="fpm"
LABEL version="deb"

# Disable frontend dialogs
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install --yes \
        gcc \
        make \
        ruby \
        ruby-dev \
    && apt-get --purge -y autoremove \
    && apt-get --yes clean \
    && rm -rf /etc/apt/sources.list.d/temp.list /var/lib/apt/lists/*

RUN gem install --no-ri --no-rdoc fpm \
    && gem cleanup

VOLUME /package
WORKDIR /package

ENTRYPOINT [ "/usr/local/bin/fpm" ]
CMD [ "--help" ]
