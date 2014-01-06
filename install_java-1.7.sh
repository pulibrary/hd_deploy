#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

#check if we have the Java version we want
if java -version 2>&1 | grep -q '^java version "1\.7\.' ; then	
# we've got the right version, nothing else to do!!!
	echo "Java version 1.7.x already installed"
	exit 0
else
# wrong version or no java installed 
	echo "Updating java"
	# try package update
	if yum install java-1.7.0-openjdk-devel -y | grep -A 1 '^Installed:' | grep -q java-1.7 ; then
	# Updated successfully
		echo "Java version 1.7.x installed successfully"
		exit 0
	else
	# Couldn't update - delete whatever is there and install from scratch
		echo 'Java 1.7 could not be installed'
		exit 1
	fi
fi  
