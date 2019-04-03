FROM ruby:2.6.2-alpine
WORKDIR /usr/src/app

RUN apk update && apk add build-base postgresql-dev nodejs yarn

RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.0.1
RUN bundle install --quiet

COPY . .
