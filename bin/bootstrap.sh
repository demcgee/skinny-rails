#!/usr/bin/env bash

# make sure we're operating from the app's source directory
APP_DIR="$( cd $( dirname ${BASH_SOURCE[0]} )/.. && pwd )"
cd $APP_DIR

# bundle install is idempotent
bundle install

# create databases
bin/rails db:create

# migrate databases
RAILS_ENV=development bin/rails db:migrate
RAILS_ENV=test        bin/rails db:migrate

# run the tests!
bin/rspec
