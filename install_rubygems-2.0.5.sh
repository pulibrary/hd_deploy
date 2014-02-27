#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# see if gem is installed
if which gem &> /dev/null ; then
	echo "RubyGems Installed"
	#check if it's the version we want
	if [[ `gem -v`  = "2.0.5" ]] ; then	
		# we've got the right version, nothing else to do!!!
		echo "RubyGems version $(gem -v) already installed"
		exit 0
	else
		# wrong version installed 
		echo "Updating rubygems"
		# try gem update
		if echo "gem update --system 2.0.5" | grep -q '^RubyGems 2.\S\+ installed' ; then
		# Updated successfully
			echo "RubyGems $(gem -v) installed successfully"
			exit 0
		else
		# Couldn't update - delete whatever is there and install from scratch
			rm -rf `which gem`
			echo 'incorrect rubygems removed'
		fi
	fi  
else
	echo "Rubygems not installed"
fi

echo "Install RugyGems from source"
mkdir -p /opt/install 
cd /opt/install
## See if we've downloaded the source tarball and the checksum matches; 
# otherwise download it
wget https://github.com/rubygems/rubygems/archive/v2.0.5.tar.gz 
# this one didn't resolve - https://codeload.github.com/rubygems/rubygems/tar.gz/v2.0.5
# also, don't need -c on wget
tar xvzf v2.0.5.tar.gz
cd rubygems-2.0.5
ruby setup.rb 
echo "RubyGems $(gem -v) installed successfully"
