#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# update ubuntu
apt-get update -y && apt-get upgrade -y

# install other necessary libraries
apt-get install build-essential git git-core curl openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmagickwand-dev imagemagick libcurl4-openssl-dev apache2-prefork-dev libxvidcore-dev

# expect is necessary for fedora install script
apt-get install expect -y

