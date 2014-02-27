#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

echo "Install the Redis server from source"
mkdir -p /opt/install && cd /opt/install

## download, make, install
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make

cp src/redis-server /usr/local/bin/
cp src/redis-cli /usr/local/bin/

# create the necessary directories
mkdir -p /etc/redis /var/redis /var/redis/6379

# begin redis init script with chkconfig
echo "# added for chkconfig compliance
# chkconfig: 2345 95 20
# description: redis_6379
# Starts the redis server
# processname: redis_6379" > /etc/rc.d/init.d/redis_6379

# add the body of the init script
cat utils/redis_init_script >> /etc/rc.d/init.d/redis_6379

# make redis script executable
chmod +x /etc/rc.d/init.d/redis_6379

# add redis to chkconfig
chkconfig --add redis_6379

# create the config file
cp redis.conf /etc/redis/6379.conf

# daemonize, set the pidfile, configure logging, and set the home dir
sed 's/^\(daemonize\ \)no.*$/\1yes/' -i /etc/redis/6379.conf
sed 's#^\(pidfile\ /var/run/\).*$#\1redis_6379.pid#' -i /etc/redis/6379.conf
sed 's/^\(loglevel\ \)verbose.*$/\1notice/' -i /etc/redis/6379.conf
sed 's#^\(dir\ \).*$#\1/var/redis/6379#' -i /etc/redis/6379.conf

service redis_6379 start

