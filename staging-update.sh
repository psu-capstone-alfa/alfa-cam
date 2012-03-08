#!/bin/sh
git fetch origin
git reset --hard origin/staging
bundle
RAILS_ENV=production rake db:reset

