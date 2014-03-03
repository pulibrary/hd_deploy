#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# back up the OOTB config
apt-get install tomcat7 -y
cp /etc/default/tomcat7 /etc/default/tomcat7.bak

user="tomcat7"
group="tomcat7"
java_home="/usr/lib/jvm/java-7-openjdk-amd64"
java_opts="\"-Djava.awt.headless=true\
 -XX:+UseG1GC\
 -XX:+UseCompressedOops\
 -XX:-UseLargePagesIndividualAllocation\
 -XX:MaxPermSize=128M\
 -Xms512m -Xmx4096m\
 -Djava.util.logging.config.file=/etc/tomcat7/logging.properties\
 -server\""

echo "# A backup of the original file with addition options is at /etc/default/tomcat7.bak
TOMCAT7_USER=$user
TOMCAT7_GROUP=$group
JAVA_HOME=$java_home
JAVA_OPTS=$java_opts" > /etc/default/tomcat7

service tomcat7 restart
