#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

# check necessary variables
#if $HYDRA_NAME doesn't exist 
#then
#abort
#else
#continue
#fi

# get the solr installer
mkdir -p /opt/install && cd /opt/install
wget http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz
tar xvzf solr-4.2.0.tgz

# check the /opt directory
ls -la /opt
# pull environment variables
source /etc/environment
# check that hydra_name exists
echo $HYDRA_NAME

# make the working solr directories
mkdir -p /opt/solr /opt/solr/$HYDRA_NAME /opt/solr/$HYDRA_NAME/lib
ls -la /opt/solr

# copy the .war and .jar files 
cp ./solr-4.2.0/dist/solr-4.2.0.war /opt/solr/$HYDRA_NAME
cp ./solr-4.2.0/dist/*.jar /opt/solr/$HYDRA_NAME/lib
cp -r ./solr-4.2.0/contrib /opt/solr/$HYDRA_NAME/lib
cp -r ./solr-4.2.0/example/solr/collection1 /opt/solr/$HYDRA_NAME/collection1
cp /opt/solr/$HYDRA_NAME/collection1/conf/lang/stopwords_en.txt /opt/solr/$HYDRA_NAME/collection1/conf/

# create the project xml file
cat > /opt/solr/$HYDRA_NAME/$HYDRA_NAME.xml <<EOF
<?xml version="1.0" encoding="utf-8"?>  
<Context docBase="/opt/solr/hydradam/solr-4.2.0.war" debug="0" crossContext="true">  
    <Environment name="solr/home" type="java.lang.String" value="/opt/solr/hydradam" override="true"/>  
</Context>
EOF

# chown /opt/fedora and /opt/solr
chown -R tomcat:tomcat /opt/fedora
chown -R tomcat:tomcat /opt/solr

# simlink tomcat to the solr xml file
ln -s /opt/solr/$HYDRA_NAME/$HYDRA_NAME.xml /etc/tomcat6/Catalina/localhost/$HYDRA_NAME.xml

# restart tomcat
service tomcat6 restart

# check tomcat, fedora, and solr
# TODO write a test for this - expect? 

