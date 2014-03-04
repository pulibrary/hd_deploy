#!/usr/bin/env bash
set -e

cd /opt
git clone --recursive https://github.com/pulibrary/pul-store
chown -R deploy:deploy pul-store
#su deploy 
cd pul-store
git checkout development
gem install bundler
bundle --deployment
bundle exec rake db:create
bundle exec rake db:migrate


