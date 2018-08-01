FROM node:8-stretch
MAINTAINER David Spreekmeester <david@grrr.nl>

RUN \
    apt-get -y update && \
    # --- Basics
    apt-get -y install build-essential apt-utils git vim && \
    # --- Install general MySQL client for easy access to db container
    apt-get -y install mysql-client && \
    # --- Install php-cli for config retrieval
    apt-get -y install php-cli && \
    # --- Install ruby gems
    apt-get -y install ruby-dev rubygems-integration && \
    gem install scss_lint && \
    gem install semver && \
    # --- Install node modules
    npm i -g gulp jshint && \
    npm link gulp && \
    # --- Deploy tools
    gem install net-ssh -v 2.9.2 && \
    gem install capistrano && \
    # --- Install python package manager
    apt-get -y install python python-pip && \
    # --- Install aws cli tool
    pip install awscli

EXPOSE 3000

