# Dockerfile
FROM ruby:2.3

ENV PORT 3000
ENV PATH /node_modules/.bin:$PATH

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get update -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
  && npm install --global yarn \
  && groupadd --system ifme \
  && useradd \
    --create-home \
    --gid ifme \
    --home-dir /home/ifme \
    --no-log-init \
    --system \
     ifme \
  && mkdir -p "/app" "/node_modules" \
  && chown ifme:ifme "/app" "/node_modules" \
  # install node modules outside of /app
  && echo "--install.modules-folder /node_modules" > /.yarnrc

WORKDIR /app
USER ifme:ifme

# add gems and npm packages before our code, so Docker can cache them
# see http://ilikestuffblog.com/2014/01/06/
COPY --chown=ifme:ifme Gemfile Gemfile.lock package.json ./
COPY --chown=ifme:ifme client/package.json client/yarn.lock ./client/
RUN bundle install && npm install

COPY --chown=ifme:ifme  . ./
RUN bundle exec rake assets:precompile

CMD ["foreman", "start", "-f", "Procfile.dev"]
EXPOSE ${PORT}
