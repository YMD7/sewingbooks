FROM ruby:2.4.0

ENV APP_ROOT /usr/src/app

WORKDIR $APP_ROOT

RUN \
  apt-get update && \
  apt-get install -y nodejs \
                     --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

COPY Gemfile      $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'install: --no-document' >> ~/.gemrc && \
  echo 'update: --no-document' >> ~/.gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle config --global path vendor/bundle && \
  bundle install

COPY . $APP_ROOT

EXPOSE 3000
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
