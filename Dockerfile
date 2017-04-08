FROM ymd7/centos7-ruby:2.4.1

ENV APP_ROOT /usr/src/app

WORKDIR $APP_ROOT

RUN \
  yum -y update && \
  yum -y install epel-release
RUN \
  yum -y install nodejs sqlite-devel && \
  yum -y install libjpeg-devel libpng-devel && \
  yum -y install ImageMagick ImageMagick-devel

COPY Gemfile      $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'install: --no-document' >> ~/.gemrc && \
  echo 'update: --no-document' >> ~/.gemrc && \
  gem install nokogiri && \
  bundle config --global jobs 4 && \
  bundle install

COPY . &APP_ROOT

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
