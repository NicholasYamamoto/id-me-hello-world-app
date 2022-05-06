FROM ruby:3.0.4

WORKDIR /usr/src/app

# Install bundler
RUN gem update --system
RUN gem install bundler

# Install runtime dependencies to host machine
COPY Gemfile* ./

RUN bundle config set --local without 'development test' \
 && bundle install --jobs 4 --retry 3 \
 # Remove Bundler cache, C source files and compiled object files
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Install client to ineteract with postgresql
RUN apt-get install postgresql-client

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]