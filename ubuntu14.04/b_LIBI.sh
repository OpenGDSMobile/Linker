#!/bin/bash


# --------------------------------------------- #
# b_LIBI.sh ----------------------------------- #
# b_LIBraries Installation.sh ----------------- #
# --------------------------------------------- #

#========================== Database(PostgreSQL + PostGIS) Installation ===============================
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main">>/etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

apt-get update && apt-get install -y postgresql-9.4 \
                                     postgresql-9.4-postgis-2.1 \
                                     postgresql-9.4-postgis-2.1-scripts \
                                     postgresql-9.4-postgis-scripts \
                                     postgresql-client-9.4 \
                                     postgresql-client-common \
                                     postgresql-common \
                                     postgresql-contrib-9.4 \
                                     postgresql-server-dev-9.4
#======================================================================================================


#================================ OpenJDK 1.7 and 1.6 Installation ====================================
apt-get install -y openjdk-6-jdk \
                   openjdk-7-jdk
#======================================================================================================


#============================== WebServer(Apache Httpd) Installation ==================================
apt-get install -y apache2 \
                   libapache2-mod-jk \
                   libapache2-mod-wsgi

apt-get install -y tomcat7 \
                   tomcat7-admin \
                   tomcat7-common \
                   libtomcat7-java
#======================================================================================================


#=================================== Build Essential Installation =====================================
apt-get install -y build-essential
#======================================================================================================


#==================================== ETC libraries Installation ======================================
apt-get install -y libtiff5-dev \
                   libgeotiff-dev \
                   libjpeg8-dev \
                   libpng12-dev \
                   libgdal1-dev \
                   gdal-bin \
                   libproj0 \
                   proj-bin \
                   proj-data \
                   python2.7-dev \
                   python-gdal \
                   unzip 
#======================================================================================================
