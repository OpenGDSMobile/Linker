#!/bin/bash

# ApplicationServer and DataServer ServiceRegisteration   =======================================================

sudo cp DataServer8 /etc/init.d/DataServer8
sudo chmod 755 /etc/init.d/DataServer8
sudo ln -s /etc/init.d/DataServer8 /etc/rc1.d/K99DataServer8
sudo ln -s /etc/init.d/DataServer8 /etc/rc2.d/S99DataServer8
service DataServer8 start

sudo cp ApplicationServer8 /etc/init.d/ApplicationServer8
sudo chmod 755 /etc/init.d/ApplicationServer8
sudo ln -s /etc/init.d/ApplicationServer8 /etc/rc1.d/K99ApplicationServer8
sudo ln -s /etc/init.d/ApplicationServer8 /etc/rc2.d/S99ApplicationServer8
service ApplicationServer8 start

# mod_jk Setting ===============================================================================================
sudo mv /etc/libapache2-mod-jk/workers.properties /etc/libapache2-mod-jk/workers.properties.back
sudo cp workers.properties /etc/libapache2-mod-jk/workers.properties
default_conf_file="/etc/apache2/sites-enabled/000-default.conf"
sudo sed -i '/CustomLog/a\\t\tJKMount /geoserver/*    dataserver \
\t\tJKMount /geoserver      dataserver \
\t\tJKMount /jenkins/*    applicationserver \
\t\tJKMount /jenkins      applicationserver \
\t\tJKMount /ApplicationServer/*      applicationserver \
\t\tJKMount /ApplicationServer	  applicationserver \
' $default_conf_file

# geoserver setup ===============================================================================================
mkdir geoserver
wget https://sourceforge.net/projects/geoserver/files/GeoServer/2.7.6/geoserver-2.7.6-war.zip -O ./geoserver/geoserver.zip
unzip ./geoserver/geoserver.zip -d ./geoserver/
cp ./geoserver/geoserver.war /opt/DataServer/webapps/
rm -r ./geoserver

geoserverWebXmlFile="/opt/DataServer/webapps/geoserver/WEB-INF/web.xml"
while [ : ];do
  if test -e $geoserverWebXmlFile
    then break
  fi
  echo "wait geoserver start..."
  sleep 2;
done
sed -i -e '45d;50d' $geoserverWebXmlFile

# Jenkins setup ==================================================================================================
wget http://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/war-stable/1.651.1/jenkins.war
mv jenkins.war /opt/ApplicationServer/webapps/
