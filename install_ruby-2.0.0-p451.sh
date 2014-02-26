#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# temporary patch until Centos image fixed
yum install wget -y

# see if ruby is installed
if which ruby > /dev/null ; then
	#check if it's the version we want
	if [[ `ruby -v` != "ruby 2.0.0"* ]] ; then	
		# remove the wrong version if it's found 
		echo "Removing existing ruby"
		# try yum
		if yum remove ruby -y 2>&1 | grep -q "No Match for argument: ruby" ; then
		# not installed using package manager, remove manually
			echo "Ruby wasn't installed using your package manager, please try uninstalling it manually." >&2
			exit 1
		fi
	else
		# we've got the right version, nothing else to do!!!
		echo "Ruby 2.0.0 already installed"
		exit 0
	fi  
fi
		
echo "Install Ruby from source"
mkdir -p /opt/install
cd /opt/install
## See if we've downloaded the source tarbal and the checksum matches; otherwise download it
[[ -e "/opt/install/ruby-2.0.0-p451.tar.gz" && `md5sum /opt/install/ruby-2.0.0-p451.tar.gz` == "9227787a9636551f1749ee8394b5ffe5"* ]] || wget -c http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p451.tar.gz
tar xvzf ruby-2.0.0-p451.tar.gz
cd ruby-2.0.0-p451
./configure
make
make install
echo "Ruby $(ruby -v) installed successfully"
