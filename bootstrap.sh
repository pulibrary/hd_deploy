#!/usr/bin/env bash

#Use to install necessary components for applications. Run on local machine.
#
# Options:
#-b
#	Only install necessary components for a blacklight application
#
#-n
#	Set app name for use in file system paths.
#
#eg. ./bootstrap.sh -b -n "blacklightapp"


set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# if which puppet > /dev/null ; then
#         echo "Puppet is already installed"
#         exit 0
# fi

BLACKLIGHT_ONLY=0



while getopts "bn:" opt; do
	case $opt in
		b)
			BLACKLIGHT_ONLY=1
		;;
		n)
			APP_NAME=$OPTARG
		;;
		\?)
			$ECHO "Invalid option: -$OPTARG" >&2
	;;
	esac
done

echo "blacklight only: $BLACKLIGHT_ONLY"
echo "app name: $APP_NAME"


if [ "$APP_NAME"x = "x" ] ; then
	echo "Please provide a name for the application"
	echo "this should not contain characters that need to be escaped"
	echo "as they will be used in file system paths"
	exit 64
fi

echo "INSTALL_USER=vagrant" | sudo tee -a /etc/environment

# set the hydra name
echo "APP_NAME=$APP_NAME" | sudo tee -a /etc/environment 


# set the rails environment
echo "RAILS_ENV=production" | sudo tee -a /etc/environment

# load the variables we just set
source /etc/environment

# Environment variables - doing inline because of environment variable issues
#/vagrant/set_variables.sh 




# Add the deploy user
/vagrant/add_deploy_user.sh

# Package prerequisites
/vagrant/install_packages.sh

# Ruby
# posted version /vagrant/install_ruby-2.0.0-p353.sh
# most recent update
/vagrant/install_ruby-2.1.2.sh


# RubyGems
/vagrant/install_rubygems-2.3.0.sh

# Java
/vagrant/install_java-1.7.sh

# Tomcat
/vagrant/install_tomcat.sh 

# MySQL
if [ $BLACKLIGHT_ONLY -eq 0 ] ; then
/vagrant/install_mysql-5.6.sh
fi

# PostgreSQL
if [ $BLACKLIGHT_ONLY -eq 1 ] ; then
/vagrant/install_postgresql.sh
fi

# Fedora
if [ $BLACKLIGHT_ONLY -eq 0 ] ; then
	/vagrant/install_fedora.sh
fi

# Solr
/vagrant/install_solr.sh

# Redis
if [ $BLACKLIGHT_ONLY -eq 0 ] ; then
	/vagrant/install_redis.sh

	# FFmpeg
	/vagrant/install_ffmpeg.sh

	# FITS
	/vagrant/install_fits.sh
fi 

# # passenger
/vagrant/install_passenger.sh

# # code
if [ $BLACKLIGHT_ONLY -eq 0 ] ; then
	/vagrant/install_code.sh
else
	/vagrant/install_blacklight.sh
fi

