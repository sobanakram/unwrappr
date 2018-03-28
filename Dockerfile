FROM ruby:2.4.2-slim
MAINTAINER "Envato <envato@envato.com>"

RUN apt-get -qq -y update && apt-get install -y \
      git
#     build-essential \
#     libmysqlclient-dev \
#     wget \
#

# ENV DOCKERIZE_VERSION v0.6.0
# RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#     && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#     && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p unwrappr
ADD . unwrappr

RUN gem install bundler
WORKDIR /unwrappr
RUN bundle install
