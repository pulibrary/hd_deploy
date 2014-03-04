#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# update ubuntu
apt-get update -y && apt-get upgrade -y

# install other necessary libraries
apt-get install -y \
  apache2-prefork-dev \
  autoconf \
  automake \
  bison \
  build-essential \
  curl \
  git \
  git-core \
  imagemagick \
  libc6-dev \
  libcurl4-openssl-dev \
  libffi-dev \
  libmagickwand-dev \
  libreadline6 \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  libtool \
  libxml2-dev \
  libxslt-dev \
  libxvidcore-dev \
  libyaml-dev \
  ncurses-dev \
  openssl \
  pkg-config \
  sqlite3 \
  subversion \
  unzip \
  zlib1g \
  zlib1g-dev



# expect is necessary for fedora install script
apt-get install expect -y

