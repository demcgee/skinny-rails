#!/usr/bin/env bash

# make sure we're operating from the app's source directory
APP_DIR="$( cd $( dirname ${BASH_SOURCE[0]} )/.. && pwd )"
cd $APP_DIR

# bundle install is idempotent
bundle install

# create databases and load schema
bin/rails db:drop
bin/rails db:create
bin/rails db:schema:load

# run the tests!
bin/rspec
