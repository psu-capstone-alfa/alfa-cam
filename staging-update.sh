#!/bin/sh
git reset --hard
git pull
bundle
rake db:reset

