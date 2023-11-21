FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /assignment
WORKDIR /assignment
ADD Gemfile /assignment/Gemfile
ADD Gemfile.lock /assignment/Gemfile.lock
RUN bundle install
ADD . /assignment