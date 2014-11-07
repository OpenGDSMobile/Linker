#!/bin/bash

settingFilename="../setting"
username=""
password=""

while read line
do
  IFS=': ' read -a array <<< $line

  if [ "${array[0]}" == "user" ] 
  then
    username="${array[1]}"
  elif [ "${array[0]}" == "passwd" ] 
  then
    password="${array[1]}"
  fi 
done < $settingFilename



#    PostgreSQL setup    ==============================================================================

#======================================================================================================


#    tomcat7 setup    =================================================================================
# user ------------------------------------------------------------------------------------------------
tomcat7_userControlFile="/var/lib/tomcat7/conf/tomcat-users.xml"
userInfo="<user username=\"$username\" password=\"$password\" roles=\"admin,manager,manager-gui\"/>"

#sed -i '19i\  <role rolename="manager"/>' $tomcat7_userControlFile
#sed -i '20i\  <role rolename="admin"/>' $tomcat7_userControlFile
#sed -i '21i\  <role rolename="manager-gui"/>' $tomcat7_userControlFile
#sed -i "22i\  $userInfo" $tomcat7_userControlFile
#------------------------------------------------------------------------------------------------------

# JK module -------------------------------------------------------------------------------------------
modJK_workerPropertyFile="/etc/libapache2-mod-jk/workers.properties"
#sed -i -e 's/tomcat6/tomcat7/g' $modJK_workerPropertyFile

oldJavaHome="/usr/lib/jvm/default-java"
newJavaHome=""

MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]
then
  echo "64bit"
  newJavaHome="/usr/lib/jvm/java-7-openjdk-amd64"
else
  echo "32bit"
  newJavaHome="/usr/lib/jvm/java-7-openjdk-i386"
fi

#sed -i -e 's#/usr/lib/jvm/default-java#'$newJavaHome'#g' $modJK_workerPropertyFile
#------------------------------------------------------------------------------------------------------

# server xml ------------------------------------------------------------------------------------------
serverXml="/var/lib/tomcat7/conf/server.xml"
sed -i '97i\    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />' $serverXml
#------------------------------------------------------------------------------------------------------
#======================================================================================================


