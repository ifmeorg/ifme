#!/bin/sh
# client.sh
# This script is run from Procfile.dev (which is run from bin/start_app

# Make sure we're in the source directory by checking for the existence
# of ./public (note that we're checking the relative path, not the absolute).
#
# bin/start_app should change to the source directory, so
# this should never happen unless something very unusual is wrong
if [ ! -d public ]; then
{
  echo "Error in setup"
  exit $?
}
fi

rails db:migrate RAILS_ENV=development
rm -rf public/webpack/development/* || true && \
cd client && \
bundle exec rake react_on_rails:locale && \
yarn install && \
yarn build:development && \

exit 0;
