# Use the tiny Alpine image to greatly reduce overall image size
FROM ruby:3.0.4-alpine3.14

# Install packages necessary to communicate with CloudSQL PostgreSQL database
RUN apk update && \
 apk upgrade && \
 apk add --no-cache \
    build-base \
    postgresql-client \
    postgresql-dev \
    tzdata

WORKDIR /opt/app

# Install runtime dependencies to host machine
COPY Gemfile* ./

RUN bundle config set --local without 'development test' && \
 # bundle config --local build.sassc --disable-march-tune-native && \
 bundle install --jobs 4 --retry 3 && \
 # Remove Bundler cache, C source files and compiled object files
 rm -rf /usr/local/bundle/cache/*.gem && \
 find /usr/local/bundle/gems/ -name "*.c" -delete && \
 find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]