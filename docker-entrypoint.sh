#!/bin/bash
set -e

bundle check || bundle install

bundle exec rake assets:precompile
