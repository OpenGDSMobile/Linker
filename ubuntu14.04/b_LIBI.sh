#!/bin/bash

echo "Input ApplicationServer admin ID: "
read ApplicationServer_admin
echo "Input AppicationServer admin password: "
read ApplicationServer_passwd

echo "Input DataServer admin ID: "
read DataServer_admin
echo "Input DataServer admin password: "
read DataServer_passwd


# ETC Installation =======================================================================================
sudo apt-get install -y build-essential
sudo apt-get install -y unzip

#========================= Database(PostgreSQL + PostGIS) Installation ===============================
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update && sudo apt-get install -y postgresql-9.4 \
                                     postgresql-9.4-postgis-2.2 \
                                     postgresql-9.4-postgis-scripts \
                                     postgresql-client-9.4 \
                                     postgresql-client-common \
                                     postgresql-common \
                                     postgresql-contrib-9.4 \
                                     postgresql-server-dev-9.4

#========================= PostgreSQL setup  =============================================================
postgresPW='postgres'
tomcatVersion='8.0.45'

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.4/main/postgresql.conf
sudo sh -c 'echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/9.4/main/pg_hba.conf'
sudo echo "alter user postgres with password '$postgresPW'" | sudo su - postgres -c 'psql template1'
sudo /etc/init.d/postgresql restart


# OpenJDK 1.7 Installation ===============================================================================
sudo apt-get install -y openjdk-7-jdk
# WebServer(Apache Httpd) Installation ===================================================================
sudo apt-get install -y apache2 \
                   libapache2-mod-jk \
# ApplicationServer install and setup    ==================================================================
sudo wget http://mirror.navercorp.com/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
sudo tar -xvf apache-tomcat-8.0.33.tar.gz
sudo mv apache-tomcat-8.0.33 ApplicationServer

ApplicationServer_userControlFile="./ApplicationServer/conf/tomcat-users.xml"
ApplicationServer_serverControlFile="./ApplicationServer/conf/server.xml"

sudo sed -i '44i\\t<role rolename="manager-gui"/>\
\t<role rolename="manager-script"/>\
\t<role rolename="manager"/>\
\t<role rolename="admin-gui"/>\
\t<role rolename="admin-script"/>\
\t<role rolename="admin"/>\
\t<role rolename="intruder"/>\n\
\t<user username="'$ApplicationServer_admin'" password="'$ApplicationServer_passwd'" roles="admin,admin-gui,admin-script,manager,manager-gui,manager-script"/>\
' $ApplicationServer_userControlFile

sudo sed -i 's/8005/8006/g
s/8080/8081/g
s/Port="8443"/Port="8443" URIEncoding="UTF-8"/g 
s/8009/8010/g
s/="localhost">/="localhost" jvmRoute="applicationserver">/g' $ApplicationServer_serverControlFile

sudo mv ApplicationServer /opt/
sudo chown ubuntu:ubuntu -R /opt/ApplicationServer/

#### DataServer setup install and setup    ==============================================================================
sudo tar -xvf apache-tomcat-8.0.33.tar.gz
sudo mv apache-tomcat-8.0.33 DataServer
sudo rm apache-tomcat-8.0.33.tar.gz

DataServer_userControlFile="./DataServer/conf/tomcat-users.xml"
DataServer_serverControlFile="./DataServer/conf/server.xml"

sudo sed -i '44i\\t<role rolename="manager-gui"/>\
\t<role rolename="manager-script"/>\
\t<role rolename="manager"/>\
\t<role rolename="admin-gui"/>\
\t<role rolename="admin-script"/>\
\t<role rolename="admin"/>\
\t<role rolename="intruder"/>\n\
\t<user username="'$DataServer_admin'" password="'$DataServer_passwd'" roles="admin,admin-gui,admin-script,manager,manager-gui,manager-script"/>\
' $DataServer_userControlFile

sudo sed -i 's/="localhost">/="localhost" jvmRoute="dataserver">/g' $DataServer_serverControlFile

sudo mv DataServer /opt/

sudo chown $USER:$USER -R /opt/DataServer/

