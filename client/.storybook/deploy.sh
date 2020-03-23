#!/bin/bash

CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD)

CHANGES_IN_STORYBOOK="client/.storybook/"
CHANGES_IN_APP_COMPONENTS="client/app/components/"
CHANGES_IN_APP_STORIES="client/app/stories/"
CHANGES_IN_APP_STYLES="client/app/styles/"
CHANGES_IN_PACKAGE_JSON="client/package.json"
CHANGES_IN_RAILS_ASSETS="app/assets/"
CHANGES_IN_RAILS_ASSETS="config/locales/"

if [[ "$CHANGED_FILES" =~ "$CHANGES_IN_STORYBOOK" || "$CHANGED_FILES" =~ "$CHANGES_IN_APP_COMPONENTS" || "$CHANGED_FILES" =~ "$CHANGES_IN_APP_STORIES" || "$CHANGED_FILES" =~ "$CHANGES_IN_APP_STYLES" || "$CHANGED_FILES" =~ "$CHANGES_IN_PACKAGE_JSON" || "$CHANGED_FILES" =~ "$CHANGES_IN_RAILS_ASSETS" || "$CHANGED_FILES" =~ "$CHANGES_IN_RAILS_LOCALES" ]]; then
  if [[ "$PWD" != */client ]]; then
    cd client || exit
  fi
  echo "Deploy changes to design.if-me.org"
  yarn build:storybook
  mv .out .public
  yarn run surge --project .public --domain design.if-me.org
else
  echo "No changes to deploy to design.if-me.org"
  exit
fi
