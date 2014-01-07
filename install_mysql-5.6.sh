#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

mkdir -p /opt/install && cd /opt/install
wget -c http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
rpm -ivh mysql-community-release-el6-5.noarch.rpm 
yum install mysql-server -y
# service mysqld start
chkconfig mysqld on
#service mysqld stop  # moved secure setup to avoid stop/restar
cp -a /var/lib/mysql/ /opt/
#mkdir /etc/mysql # not sure mysql will look here for config files..
#mv /etc/my.cnf /etc/mysql/ # see above

# Use SED to pdate my.cnf defaults
sed '
/datadir\s*=/ d
/character_set_server\s*=/ d
/default-storage-engine\s*=/ d
/\[mysqld\]/ a\
datadir = /opt/mysql \
character_set_server = utf8 \
default-storage-engine = InnoDB' -i.bak /etc/my.cnf

#chown -R mysql:mysql /opt/mysql # doesn't appear to be necessary if you cp -a above

service mysqld start
/usr/bin/mysql_secure_installation < /vagrant/mysql_secure_non-secure_defaults.txt
mysql -u root -ppassword < /vagrant/mysql_fedora_tables.txt 
