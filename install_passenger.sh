#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# Follow this:
# http://www.modrails.com/documentation/Users%20guide%20Apache.html#install_on_debian_ubuntu

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7

# Add HTTPS support for APT. Our APT repository is stored on an HTTPS server.
apt-get install apt-transport-https ca-certificates

echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main" > /etc/apt/sources.list.d/passenger.list

chown root: /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get -y update
apt-get -y install libapache2-mod-passenger

echo "<VirtualHost *:80>
  ServerName pulstore.princeton.edu
  PassengerRuby /usr/local/bin/ruby
  PassengerAppRoot /opt/pul-store
  DocumentRoot /opt/pul-store/public
  <Directory /opt/pul-store/public>
    AllowOverride all
    # MultiViews must be turned off.
    Options -MultiViews
  </Directory>
</VirtualHost>" > /etc/apache2/sites-available/001-pulstore

a2ensite 001-pulstore
a2dissite 000-default

# In /etc/apache2/mods-available/passenger.conf 
# change PassengerDefaultRuby to /usr/local/bin/ruby

# Change /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini
# change ruby_libdir to /usr/local/lib/ruby/vendor_ruby

service apache2 restart

