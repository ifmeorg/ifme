# Dockerfile
FROM quay.io/aptible/ruby:2.3

RUN apt-get update && apt-get -y install build-essential

# System prerequisites
RUN apt-get update && apt-get -y install libpq-dev curl apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# If you require additional OS dependencies, install them here:
# RUN apt-get update && apt-get -y install imagemagick nodejs

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn -y


# Add Gemfile before rest of repo, for Docker caching purposes
# See http://ilikestuffblog.com/2014/01/06/
ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

ADD . /app
RUN bundle exec rake assets:precompile

ENV PORT 3000
EXPOSE 3000
