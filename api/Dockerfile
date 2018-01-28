FROM ruby:2.4.2-alpine

# Installing required packages
RUN apk add --no-cache \
    build-base \
    tzdata \
    postgresql-dev \
    imagemagick


ENV RAILS_ENV='development'
ENV RAKE_ENV='development'

WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN bundle install

