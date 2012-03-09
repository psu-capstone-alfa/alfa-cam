#!/bin/sh

bundle exec rake ci:staging:deploy:begin

git fetch origin
git reset --hard origin/staging
bundle
RAILS_ENV=production bundle exec rake db:reset assets:precompile
touch tmp/restart.txt
