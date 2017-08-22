FROM ruby:2.2.5-slim

# Runtime
ENV APP_HOME=/usr/src/app \
    LANG=C.UTF-8 \
    TERM='xterm-256color' \
    RAILS_ENV=production

WORKDIR $APP_HOME

RUN set -ex \
    && apt-get update -qq \
    && apt-get install -y \
      build-essential \
      libpq-dev \
      nodejs \
      git

# Build
COPY Gemfile* $APP_HOME/

RUN set -ex \
    && git config --system user.name Docker \
    && git config --system user.email docker@localhost \
    && bundle install --without test development --jobs 4 --retry 3

COPY . $APP_HOME

RUN rake assets:precompile

# App
EXPOSE 3000

RUN chown -R nobody:nogroup $APP_HOME
USER nobody

CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
