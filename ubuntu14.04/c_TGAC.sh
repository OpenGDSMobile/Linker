#!/bin/bash

# --------------------------------------------- #
# c_TGAC.sh ----------------------------------- #
# c_Tomcat GeoServer Apache Configuration.sh -- #
# --------------------------------------------- #


#### init setup    ====================================================================================
settingFilename="../setting"
username=""
password=""
databasename=""
tomcatDebugListeningPort=""

while read line
do
  IFS=': ' read -a array <<< $line

  if [ ${array[0]} == "user" ]; then
    username=${array[1]}
  elif [ ${array[0]} == "passwd" ]; then
    password=${array[1]}
  elif [ ${array[0]} == "database" ]; then
    databasename=${array[1]}
  elif [ ${array[0]} == "tomcatDebugListeningPort" ]; then
    tomcatDebugListeningPort=${array[1]}
  fi 
done < $settingFilename
#======================================================================================================


#### PostgreSQL setup    ==============================================================================


#======================================================================================================


#### tomcat7 setup    =================================================================================
# user ------------------------------------------------------------------------------------------------
tomcat7_userControlFile="/var/lib/tomcat7/conf/tomcat-users.xml"
userInfo="<user username=\"$username\" password=\"$password\" roles=\"admin,manager,manager-gui\"/>"

sed -i '19i\  <role rolename="manager"/>' $tomcat7_userControlFile
sed -i '20i\  <role rolename="admin"/>' $tomcat7_userControlFile
sed -i '21i\  <role rolename="manager-gui"/>' $tomcat7_userControlFile
sed -i "22i\  $userInfo" $tomcat7_userControlFile
#------------------------------------------------------------------------------------------------------

# JK module -------------------------------------------------------------------------------------------
modJK_workerPropertyFile="/etc/libapache2-mod-jk/workers.properties"
sed -i -e 's/tomcat6/tomcat7/g' $modJK_workerPropertyFile

oldJavaHome="/usr/lib/jvm/default-java"
newJavaHome=""

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]
then
  echo "64bit"
  newJavaHome="/usr/lib/jvm/java-7-openjdk-amd64/"
else
  echo "32bit"
  newJavaHome="/usr/lib/jvm/java-7-openjdk-i386/"
fi

sed -i -e 's#/usr/lib/jvm/default-java#'$newJavaHome'#g' $modJK_workerPropertyFile
#------------------------------------------------------------------------------------------------------

# server xml ------------------------------------------------------------------------------------------
serverXml="/var/lib/tomcat7/conf/server.xml"
sed -i '97i\    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />' $serverXml
/usr/share/tomcat7/bin/catalina.sh run
#------------------------------------------------------------------------------------------------------

# symbolic link ---------------------------------------------------------------------------------------
ln -s /var/lib/tomcat7/conf /usr/share/tomcat7/conf
ln -s /etc/tomcat7/policy.d/03catalina.policy /usr/share/tomcat7/conf/catalina.policy
ln -s /var/log/tomcat7 /usr/share/tomcat7/log
ln -s /var/lib/tomcat7/common /usr/share/tomcat7/common
ln -s /var/lib/tomcat7/server /usr/share/tomcat7/server
ln -s /var/lib/tomcat7/shared /usr/share/tomcat7/shared

chmod -R 777 /usr/share/tomcat7/conf
#------------------------------------------------------------------------------------------------------

# debug env setting -----------------------------------------------------------------------------------
bashrcFile="/etc/bash.bashrc"
sed -i '$ a\export JAVA_OPTS="-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address='$tomcatDebugListeningPort',server=y,suspend=n"' $bashrcFile
#------------------------------------------------------------------------------------------------------
#======================================================================================================


#### GeoServer setup    ===============================================================================
mkdir -p ./downloads/geoserver
wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.6.0/geoserver-2.6.0-war.zip/download \
     -O ./downloads/geoserver.zip
unzip ./downloads/geoserver.zip -d ./downloads/geoserver
cp ./downloads/geoserver/geoserver.war /var/lib/tomcat7/webapps/geoserver.war

service tomcat7 restart  # deply geoserver
#======================================================================================================


#### Apache + GeoServer =============================================================================== 
apacheSettingFile="/etc/apache2/sites-available/000-default.conf"
sed -i '22i\        JKMount /geoserver/* ajp13_worker' $apacheSettingFile

service apache2 restart # test : http://server_ip_address/geoserver
#======================================================================================================


#### GeoServer JSONP Setting ========================================================================== 
geoserverWebXmlFile="/var/lib/tomcat7/webapps/geoserver/WEB-INF/web.xml"
sed -i -e '45d;50d' $geoserverWebXmlFile
#======================================================================================================

