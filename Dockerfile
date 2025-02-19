FROM ruby:3.1.0

LABEL maintainer="felipe@yerba.dev"

RUN apt-get update && apt-get install -y nodejs --no-install-recommends
RUN gem install bundler:2.2.21

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 4

COPY . .

RUN RACK_ENV=production SECRET_KEY_BASE=1 bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
