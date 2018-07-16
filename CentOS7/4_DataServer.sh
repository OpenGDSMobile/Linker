#!/bin/bash



managerID=${1:?"Requires an argument: user ID"}
echo "Input user ID: $managerID"
managerPW=${2:?"Requires an argumnet: manager PW"}
echo "Input manager PW: $managerPW"



###Application Server Install & Setting###
wget http://mirror.navercorp.com/apache/tomcat/tomcat-8/v8.0.52/bin/apache-tomcat-8.0.52.tar.gz
tar -xvf apache-tomcat-8.0.52.tar.gz
mv apache-tomcat-8.0.52 DataServer
rm apache-tomcat-8.0.52.tar.gz
str1="\t<role rolename='manager-gui'\/>\n"
str2="\t<role rolename='manager-script'\/>\n"
str3="\t<role rolename='manager'\/>\n"
str4="\t<role rolename='admin-gui'\/>\n"
str5="\t<role rolename='admin-script'\/>\n"
str6="\t<role rolename='admin'\/>\n"
str7="\t<role rolename='$managerID'\/<\n"
str8="\t<user username='admin' password='adminPass' roles='admin,admin-gui,admin-script,manager,manager-gui,manager-script'\/>\n"
str9="\t<user username='$managerID' password='$managerPW' roles='admin,admin-gui,admin-script,manager,manager-gui,manager-script'\/>\n"
str10="<\/tomcat-users>"
fullStr=$str1$str2$str3$str4$str5$str6$str7$str8$str9$str10

sed -i "s/<\/tomcat-users>/$fullStr/g" ./DataServer/conf/tomcat-users.xml

sed -i 's/="localhost">/="localhost" jvmRoute="dataserver">/g' ./DataServer/conf/server.xml

sudo mv ./DataServer /opt/


###Data Server init.d Setting & start###
cp DataServer8 DataServer_backup
sed -i "s/TOMCAT_USER=centos/TOMCAT_USER=$managerID/g" DataServer8
sudo mv DataServer8 /etc/init.d/
mv DataServer_backup DataServer8
sudo chmod +x /etc/init.d/DataServer8
sudo chkconfig --add DataServer8
sudo chkconfig --level 2345 DataServer8 on
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

###GeoServer Install ###
wget https://sourceforge.net/projects/geoserver/files/GeoServer/2.7.6/geoserver-2.7.6-war.zip
mkdir geoserver
unzip geoserver-2.7.6-war.zip -d geoserver
mv ./geoserver/geoserver.war /opt/DataServer/webapps/
rm -rf geoserver
rm -rf geoserver-2.7.6-war.zip

service DataServer8 start

geoserverWeb="/opt/DataServer/webapps/geoserver/WEB-INF/web.xml"
while [ : ];do 
  if test -e $geoserverWeb
    then break
  fi
  echo "wait geoserver start..."
  sleep 2;
done

sudo sed -i -e '45d;50d' $geoserverWeb


