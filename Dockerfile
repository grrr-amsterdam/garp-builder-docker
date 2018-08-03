FROM node:8-stretch
MAINTAINER David Spreekmeester <david@grrr.nl>

ARG BUILD_HOME=/home/builder
ENV APPLICATION_ENV development

# Add PHP Composer path to current path
ENV PATH $PATH:./vendor/bin
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN \
    mkdir -p /home/builder && \
    apt-get -y update && \
    # --- Basics
    apt-get -y install build-essential apt-utils git vim && \
    # --- Install general MySQL client for easy access to db container
    apt-get -y install mysql-client && \
    # --- Install php-cli for config retrieval
    apt-get -y install php-cli php-mbstring php-xml php-curl && \
    # --- Install ruby gems
    apt-get -y install ruby-dev rubygems-integration && \
    gem install scss_lint && \
    gem install semver && \
    # --- Install node modules
    npm i -g gulp jshint gulp-load-plugins && \
    npm link gulp && \
    # --- Deploy tools
    gem install net-ssh -v 2.9.2 && \
    gem install capistrano && \
    # --- Install python package manager
    apt-get -y install python python-pip && \
    # --- Install aws cli tool
    pip install awscli && \
    ln -s $BUILD_HOME/build/gulpfile.js $BUILD_HOME/gulpfile.js && \
    ln -s $BUILD_HOME/build/package.json $BUILD_HOME/package.json && \
    ln -s $BUILD_HOME/build/composer.json $BUILD_HOME/composer.json && \
    ln -s $BUILD_HOME/build/Makefile $BUILD_HOME/Makefile

WORKDIR $BUILD_HOME
EXPOSE 3000
EXPOSE 3001
