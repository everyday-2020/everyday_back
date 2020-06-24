FROM ruby:2.6.3

WORKDIR /opt/app

RUN apt-get update && \
    apt-get install -y ffmpeg ffmpegthumbnailer

COPY . /opt/app

RUN gem install bundler -v '2.1.4' && \
    bundle install && \
    rails db:setup

#ENV RAILS_ENV production

CMD ["rails", "s" , "-b",  "0.0.0.0"]
