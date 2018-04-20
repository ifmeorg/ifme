#! /usr/bin/env bash

set -e -x -u

export NOKOGIRI_USE_SYSTEM_LIBRARIES=t

pushd chromedriver-helper

  bundle install
  bundle exec rake spec

popd
