FROM ruby:2.5.3-alpine3.8

RUN apk update && apk add bash build-base \
  tzdata curl openssl openssl-dev \
  nginx supervisor

RUN mkdir /app
WORKDIR /app

COPY ./app/Gemfile .
COPY ./app/Gemfile.lock .
RUN bundle

COPY ./app/ .

CMD supervisord -c /app/supervisord.conf

