#!/bin/sh
git reset --hard
git pull
bundle
RAILS_ENV=production rake db:reset

