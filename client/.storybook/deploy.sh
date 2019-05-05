#!/bin/bash

if [[ "$PWD" != */client ]]; then
  cd client || exit
fi

CHANGES_IN_STORYBOOK=$(git diff .storybook/)
CHANGES_IN_APP_COMPONENTS=$(git diff app/components/)
CHANGES_IN_APP_STORIES=$(git diff app/stories/)
CHANGES_IN_APP_STYLES=$(git diff app/styles/)
CHANGES_IN_PACKAGE_JSON=$(git diff package.json)
CHANGES_IN_RAILS_ASSETS=$(git diff ../app/assets/)
CHANGES_IN_RAILS_LOCALES=$(git diff ../config/locales/)

if [[ "$CHANGES_IN_STORYBOOK" || "$CHANGES_IN_APP_COMPONENTS" || "$CHANGES_IN_APP_STORIES" || "$CHANGES_IN_APP_STYLES" || "$CHANGES_IN_PACKAGE_JSON" || "$CHANGES_IN_RAILS_ASSETS" || "$CHANGES_IN_RAILS_LOCALES" ]]; then
  echo "Deploy changes to design.if-me.org"
  yarn build:storybook
  mv .out .public
  yarn run surge --project .public --domain design.if-me.org
else
  echo "No changes to deploy to design.if-me.org"
  exit
fi
