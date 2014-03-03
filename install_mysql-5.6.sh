#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

apt-get install mysql-server -y

# set mysql to start automatically on reboot
#chkconfig mysqld on

# move mysql to /opt
#cp -a /var/lib/mysql/ /opt/
#ls -la /opt

# Use SED to update my.cnf defaults
sed '
/character_set_server\s*=/ d
/default-storage-engine\s*=/ d
/\[mysqld\]/ a\
character_set_server = utf8 \
default-storage-engine = InnoDB' -i.bak /etc/mysql/my.cnf

# start mysql and run through the secure installation
#sudo service mysql stop
service mysql start
/usr/bin/mysql_secure_installation < /vagrant/mysql_secure_non-secure_defaults.txt
mysql -u root -ppassword < /vagrant/mysql_fedora_tables.txt 
