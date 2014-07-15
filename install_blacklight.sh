#!/usr/bin/env bash
set -e

cd /opt

rails new $APP_NAME -m https://raw.github.com/projectblacklight/blacklight/master/template.demo.rb