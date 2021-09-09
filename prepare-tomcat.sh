#!/bin/sh

PROGNAME=$(basename $0)

TOMCAT10=10.0.10
TOMCAT9=9.0.52
TOMCAT8=8.5.70

function usage() {
    echo "Usage: $PROGNAME [OPTIONS]"
}


function donwloadApp() {
  if [ ! -e sample.war ]; then
    echo "Downloading..."
    curl -LO https://tomcat.apache.org/tomcat-10.0-doc/appdev/sample/sample.war
  else
    echo "sample.war is existed."
  fi
}

function tomcatDeploy() {
  unzip apache-tomcat-${TOMCAT}.zip
  rm apache-tomcat-${TOMCAT}.zip
  rm -fr apache-tomcat-*/webapps/*
  cp sample.war apache-tomcat-${TOMCAT}/webapps/
  chmod +x apache-tomcat-${TOMCAT}/bin/*.sh
}

function tomcat8() {
  donwloadApp
  curl -OL https://dlcdn.apache.org/tomcat/tomcat-8/v${TOMCAT}/bin/apache-tomcat-${TOMCAT}.zip
  tomcatDeploy
}

function tomcat9() {
  donwloadApp
  curl -OL https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT}/bin/apache-tomcat-${TOMCAT}.zip
  tomcatDeploy
}

function tomcat10() {
  donwloadApp
  curl -OL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT}/bin/apache-tomcat-${TOMCAT}.zip
  tomcatDeploy
}

function cleanup() {
  rm -fr apache-tomcat-*
  rm sample.war
}

for OPT in "$@"
do
  case $OPT in
    -h | --help)
      usage
      exit 1
      ;;
    -v | --version)
      if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
        echo "$PROGNAME: option requires an argument -- $1" 1>&2
      else
        case $2 in
          8)
            TOMCAT=$TOMCAT8
            tomcat8
            ;;
          9)
            TOMCAT=$TOMCAT9
            tomcat9
            ;;
          10)
            TOMCAT=$TOMCAT10
            tomcat10
            ;;
          clean)
            cleanup
            ;;
        esac
      fi
      
      ;;
  esac
done

# docker build -t tomcat-app:10 -f Dockerfile.tomcat10 .
# docker build -t tomcat-app:9 -f Dockerfile.tomcat9 .
# docker build -t tomcat-app:8 -f Dockerfile.tomcat8 .