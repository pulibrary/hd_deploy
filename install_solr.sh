#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# check necessary variables
#if $APP_NAME doesn't exist solr-4.9.0
#then
#abort
#else
#continue
#fi

# get the solr installer
mkdir -p /opt/install && cd /opt/install
wget -c http://archive.apache.org/dist/lucene/solr/4.9.0/solr-4.9.0.tgz
tar xvzf solr-4.9.0.tgz

# check the /opt directory
ls -la /opt
# pull environment variables
source /etc/environment
# check that APP_name exists
echo $APP_NAME

# make the working solr directories
mkdir -p /opt/solr /opt/solr/$APP_NAME /opt/solr/$APP_NAME/lib
ls -la /opt/solr

# copy the .war and .jar files 
cp ./solr-4.9.0/dist/solr-4.9.0.war /opt/solr/$APP_NAME
cp ./solr-4.9.0/dist/*.jar /opt/solr/$APP_NAME/lib
cp -r ./solr-4.9.0/contrib /opt/solr/$APP_NAME/lib
cp -r ./solr-4.9.0/example/solr/collection1 /opt/solr/$APP_NAME/collection1
cp /opt/solr/$APP_NAME/collection1/conf/lang/stopwords_en.txt /opt/solr/$APP_NAME/collection1/conf/
# for v 4.3 
cp ./solr-4.9.0/example/lib/ext/*.jar /usr/share/tomcat7/lib/ 
cp ./solr-4.9.0/example/cloud-scripts/log4j.properties /usr/share/tomcat7/lib/

# create the project xml file
cat > /opt/solr/$APP_NAME/$HYDRA_NAME.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>  
<Context docBase="/opt/solr/pul-store/solr-4.9.0.war" debug="0" crossContext="true">  
    <Environment name="solr/home" type="java.lang.String" value="/opt/solr/pul-store" override="true"/>  
</Context>
EOF

# chown /opt/fedora and /opt/solr
chown -R tomcat7:tomcat7 /opt/fedora
chown -R tomcat7:tomcat7 /opt/solr

# simlink tomcat to the solr xml file
ln -s /opt/solr/$APP_NAME/$APP_NAME.xml /etc/tomcat7/Catalina/localhost/$APP_NAME.xml

# restart tomcat
service tomcat7 restart

# check tomcat, fedora, and solr
# TODO write a test for this - expect? 

