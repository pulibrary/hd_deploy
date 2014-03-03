#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# set environment variables for fedora
grep -q '^FEDORA_HOME=' /etc/environment || echo "FEDORA_HOME=/opt/fedora" | sudo tee -a /etc/environment
echo 'PATH=$PATH:$FEDORA_HOME/server/bin:$FEDORA_HOME/client/bin' | sudo tee -a /etc/profile.d/fedora.sh
source /etc/environment
source /etc/profile.d/fedora.sh

# check the output of "echo $PATH"
if
	[[ $(echo $PATH) == *fedora/server/bin*fedora/client/bin* ]]
then	
	echo "The path is ready to install Fedora"
else
	echo "The path is not correct, Fedora cannot be installed." >&2
	exit 1
fi

# add the vagrant user to the tomcat group
usermod -G tomcat7 -a vagrant
# check that this worked
if
	[[ $(id vagrant) == *tomcat* ]]
then
	echo "The vagrant user is a member of the tomcat group"
else
	echo "The vagrant user must be a member of the tomcat group to install fedora"
	exit 1
fi

# change owners on /opt - fedora expect script is run as vagrant
chown vagrant:vagrant /opt

# get the fedora installer
mkdir -p /opt/install && cd /opt/install
wget -c http://sourceforge.net/projects/fedora-commons/files/fedora/3.6.2/fcrepo-installer-3.6.2.jar

# call expect script for interactive section with fedora installer
expect /vagrant/install_fedora.exp

# will chown /opt/fedora and restart tomcat after solr is installed too
