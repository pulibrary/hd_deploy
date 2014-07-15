#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

APP_NAME=$1
if [ "$APP_NAME"x == "x" ] ; then
		APP_NAME=pul-store
fi

# set the install user
echo "INSTALL_USER=vagrant" | sudo tee -a /etc/environment

# set the hydra name
echo "APP_NAME=$APP_NAME" | sudo tee -a /etc/environment 


# set the rails environment
echo "RAILS_ENV=production" | sudo tee -a /etc/environment

# load the variables we just set
source /etc/environment

