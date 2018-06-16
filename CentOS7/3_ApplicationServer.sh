#!/bin/bash



managerID=${1:?"Requires an argument: User ID"}
echo "Input user ID: $managerID"
managerPW=${2:?"Requires an argumnet: manager PW"}
echo "Input manager PW: $managerPW"



###Application Server Install & Setting###
wget http://mirror.navercorp.com/apache/tomcat/tomcat-8/v8.0.52/bin/apache-tomcat-8.0.52.tar.gz
tar -xvf apache-tomcat-8.0.52.tar.gz
mv apache-tomcat-8.0.52 ApplicationServer
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

sed -i "s/<\/tomcat-users>/$fullStr/g" ./ApplicationServer/conf/tomcat-users.xml

sed -i 's/port="8005"/port="8006"/g' ./ApplicationServer/conf/server.xml

sed -i 's/port="8080"/port="8081"/g' ./ApplicationServer/conf/server.xml

sed -i 's/port="8009"/port="8010"/g' ./ApplicationServer/conf/server.xml

sed -i 's/Port="8443"/Port="8443" URIEncoding="UTF-8"/g' ./ApplicationServer/conf/server.xml

sed -i 's/="localhost">/="localhost" jvmRoute="applicationserver">/g' ./ApplicationServer/conf/server.xml

sudo mv ApplicationServer /opt/


###Application Server init.d Setting & start###
cp ApplicationServer8 ApplicationServer_backup
sed -i "s/TOMCAT_USER=centos/TOMCAT_USER=$managerID/g" ApplicationServer8
sudo mv ApplicationServer8 /etc/init.d/
mv ApplicationServer_backup ApplicationServer8
sudo chmod +x /etc/init.d/ApplicationServer8
sudo chkconfig --add ApplicationServer8
sudo chkconfig --level 2345 ApplicationServer8 on
sudo firewall-cmd --permanent --zone=public --add-port=8081/tcp  
sudo firewall-cmd --reload

###Jenkins Install ###
#wget http://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/war-stable/1.651.1/jenkins.war
#mv jenkins.war /opt/ApplicationServer/webapps/



service ApplicationServer8 start
