#!/usr/bin/env bash
set -e

cd /opt
su vagrant
git clone --recursive https://github.com/pulibrary/pul-store
cd pul-store
git checkout development
gem install bundler
bundle --deployment
rake db:create
rake db:migrate


