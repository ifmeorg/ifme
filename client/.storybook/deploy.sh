#!/bin/bash

if [[ "$PWD" != */client ]]; then
  cd client || exit
fi

CHANGES_IN_CLIENT=$(git diff)

if [[ "$CHANGES_IN_CLIENT" ]]; then
  echo "Deploy changes to design.if-me.org"
  yarn build:storybook
  mv .out .public
  yarn run surge --project .public --domain design.if-me.org
else
  echo "No changes to deploy to design.if-me.org"
  exit
fi
