#!/bin/bash
set -e

bundle check || bundle install

# run only when needed
# bundle exec rake assets:precompile

exec "$@"
