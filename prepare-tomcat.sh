#!/bin/sh

TOMCAT10=10.0.10
TOMCAT9=9.0.52
TOMCAT8=8.5.70

curl -OL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT10}/bin/apache-tomcat-${TOMCAT10}.zip
curl -OL https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT9}/bin/apache-tomcat-${TOMCAT9}.zip
curl -OL https://dlcdn.apache.org/tomcat/tomcat-8/v${TOMCAT8}/bin/apache-tomcat-${TOMCAT8}.zip

unzip apache-tomcat-${TOMCAT10}.zip
unzip apache-tomcat-${TOMCAT9}.zip
unzip apache-tomcat-${TOMCAT8}.zip
rm apache-tomcat-${TOMCAT10}.zip
rm apache-tomcat-${TOMCAT9}.zip
rm apache-tomcat-${TOMCAT8}.zip

rm -fr apache-tomcat-*/webapps/*

curl -LO https://tomcat.apache.org/tomcat-10.0-doc/appdev/sample/sample.war

cp sample.war apache-tomcat-${TOMCAT10}/webapps/
cp sample.war apache-tomcat-${TOMCAT9}/webapps/
cp sample.war apache-tomcat-${TOMCAT8}/webapps/

chmod +x apache-tomcat-${TOMCAT10}/bin/*.sh
chmod +x apache-tomcat-${TOMCAT9}/bin/*.sh
chmod +x apache-tomcat-${TOMCAT8}/bin/*.sh

# docker build -t tomcat-app:10 -f Dockerfile.tomcat10 .
# docker build -t tomcat-app:9 -f Dockerfile.tomcat9 .
# docker build -t tomcat-app:8 -f Dockerfile.tomcat8 .