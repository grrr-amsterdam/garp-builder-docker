FROM node:8-stretch
MAINTAINER David Spreekmeester <david@grrr.nl>
ENV APPLICATION_ENV development

ARG BUILD_HOME=/home/builder

RUN \
    mkdir -p /home/builder && \
    apt-get -y update && \
    # --- Basics
    apt-get -y install build-essential apt-utils git vim && \
    # --- Install general MySQL client for easy access to db container
    apt-get -y install mysql-client && \
    # --- Install php-cli for config retrieval
    apt-get -y install php-cli php-mbstring && \
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
    ln -s $BUILD_HOME/build/package.json $BUILD_HOME/package.json

WORKDIR $BUILD_HOME
EXPOSE 3000
EXPOSE 3001
