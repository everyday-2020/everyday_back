FROM ruby:2.7.1

WORKDIR /opt/app

RUN apt-get update && \
    apt-get install -y sqlite3 libsqlite3-dev ffmpeg ffmpegthumbnailer

COPY . /opt/app

RUN gem install bundler -v '2.1.4' && \
    bundle install

#ENV RAILS_ENV production

CMD ["rails", "s" , "-b",  "0.0.0.0"]
