FROM ubuntu:16.04
MAINTAINER Kazuki Morozumi <kazuki.m777@gmail.com>

ENV build_deps 'automake libcurl4-gnutls-dev make gcc curl bzip2'
ENV libs 'locales'
RUN apt-get update \
  && apt-get install -y ${libs} ${build_deps}

# locale setting
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV rowell_archive_url 'https://github.com/roswell/roswell/archive/release.tar.gz'
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

ENV PATH /root/.roswell/bin:/usr/local/bin:$PATH