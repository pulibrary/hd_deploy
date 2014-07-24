#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

apt-get -q -y install postgresql


# set up orangelight user for postgresql
su - postgres
psql -c "CREATE ROLE orangelight with createdb login password 'orange';"
exit