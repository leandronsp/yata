#!/bin/bash

bundle
bundle exec rake migratedb
exec "$@"
