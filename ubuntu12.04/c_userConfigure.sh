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
tomcat7_userControlFile="/var/lib/tomcat7/conf/tomcat-users.xml"
userInfo="<user username=\"$username\" password=\"$password\" roles=\"admin,manager,manager-gui\"/>"

sed -i '19i\  <role rolename="manager"/>' $tomcat7_userControlFile
sed -i '20i\  <role rolename="admin"/>' $tomcat7_userControlFile
sed -i '21i\  <role rolename="manager-gui"/>' $tomcat7_userControlFile
sed -i "22i\  $userInfo" $tomcat7_userControlFile
#======================================================================================================














