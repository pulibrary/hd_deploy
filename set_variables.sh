#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# set the install user
echo "INSTALL_USER=vagrant" | sudo tee -a /etc/environment

# set the hydra name
echo "HYDRA_NAME=pul-store" | sudo tee -a /etc/environment 

# set the rails environment
echo "RAILS_ENV=production" | sudo tee -a /etc/environment

# load the variables we just set
source /etc/environment

