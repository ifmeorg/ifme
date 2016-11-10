#!/bin/bash

git push ifmeprod production -f
git push heroku production:master -f
