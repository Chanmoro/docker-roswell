FROM debian:jessie
MAINTAINER Kazuki Morozumi <kazuki.m777@gmail.com>

ENV build_deps 'automake libcurl4-gnutls-dev make gcc curl bzip2'
ENV rowell_archive_url 'https://github.com/roswell/roswell/archive/release.tar.gz'

RUN apt-get update \
  && apt-get install -y ${build_deps}

RUN echo 'install roswell' \
  && curl -SL ${rowell_archive_url} \
  | tar -xzC /tmp/ \
  && cd /tmp/roswell-release \
  && sh bootstrap \
  && ./configure \
  && make \
  && make install \
  && rm -rf /tmp/roswell-release

RUN ros setup