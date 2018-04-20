#!/bin/bash

set -o errexit -o nounset

REPO="https://${GH_TOKEN}@github.com/rubysec/rubysec.github.io.git"
DIR="_site"

git clone $REPO $DIR

cd $DIR

git config user.name "RubySec CI"
git config user.email "ci@rubysec.com"

bundle install --jobs=3 --retry=3
bundle exec rake advisories

git push -q
