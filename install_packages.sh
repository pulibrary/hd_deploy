#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# set the rails environment
echo "RAILS_ENV=production" | sudo tee -a /etc/environment && source /etc/environment

# update CentOS
yum update -y && yum upgrade -y

# install Development Tools
yum groupinstall "Development Tools" -y

# install other necessary libraries
yum install screen wget curl-devel httpd-devel openssl-devel readline-devel ruby-devel sqlite-devel mysql-devel tcl ImageMagick-devel nasm libxml2-devel libxslt-devel libyaml-devel -y

# expect is necessary for fedora install script
yum install expect -y

