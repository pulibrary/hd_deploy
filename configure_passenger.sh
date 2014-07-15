#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

gem install passenger
passenger-install-apache2-module
# ENTER
# ENTER
# ENTER

echo "<IfModule mod_passenger.c>
    PassengerRoot /usr/local/lib/ruby/gems/2.1.0/gems/passenger-4.0.37
    PassengerDefaultRuby /usr/local/bin/ruby
  </IfModule>" > /etc/apache2/mods-available/passenger.conf

echo "LoadModule passenger_module /usr/local/lib/ruby/gems/2.1.0/gems/passenger-4.0.37/buildout/apache2/mod_passenger.so
" > /etc/apache2/mods-available/passenger.load

a2enmod passenger

echo "<VirtualHost *:80>
  ServerName $APP_NAME.princeton.edu # THIS IS PROBABLY WRONG
  PassengerRuby /usr/local/bin/ruby
  PassengerAppRoot /opt/$APP_NAME
  DocumentRoot /opt/$APP_NAME/public
  <Directory /opt/$APP_NAME/public>
    AllowOverride all
    # MultiViews must be turned off.
    Options -MultiViews
  </Directory>
</VirtualHost>" > /etc/apache2/sites-available/001-$APP_NAME

a2ensite 001-$APP_NAME
a2dissite 000-default

service apache2 restart
