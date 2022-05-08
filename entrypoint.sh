#!/bin/sh

# Precompile the Rails assets
RAILS_ENV=production bundle exec rake assets:precompile

# Start the Rails server
echo "Starting the Rails server. . ."
bundle exec rails server