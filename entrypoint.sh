#!/bin/sh

cd /opt/app

# Precompile the Rails assets
RAILS_ENV=production bundle exec rake assets:precompile

# Start the Rails server
echo "Starting the Rails server. . ."
RAILS_ENV=production RAILS_LOG_TO_STDOUT=true bundle exec rails server