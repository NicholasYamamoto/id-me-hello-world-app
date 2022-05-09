# Utilize a multi-stage build to cut down on the final image size
FROM ruby:3.0.4-alpine3.14 AS builder

# Install necessary packages for building
RUN apk update && \
 apk upgrade && \
 apk add --no-cache \
    build-base \
    postgresql-dev \
    tzdata

WORKDIR /opt/app

COPY Gemfile* ./

# Install the Gems to generate Build Artifacts
RUN bundle config set --local without 'development test' && \
 bundle install --jobs 4 --retry 3 && \
 # Remove Bundler cache, C source files and compiled object files
 rm -rf /usr/local/bundle/cache/*.gem && \
 find /usr/local/bundle/gems/ -name "*.c" -delete && \
 find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . .

# Build the Production-ready image
FROM ruby:3.0.4-alpine3.14

# Install packages necessary to communicate with CloudSQL PostgreSQL database
RUN apk add --update --no-cache \
 postgresql-client \
 postgresql-dev \
 tzdata

# Copy over the app and any Build Artifacts
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /opt/app /opt/app

WORKDIR /opt/app

# Use the default port for the Puma http server
EXPOSE 3000

# Run script to run Rails asset pipeline and start the server
RUN chmod 0755 entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
