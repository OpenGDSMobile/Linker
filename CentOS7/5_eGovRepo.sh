#!/bin/bash



managerID=${1:?"Requires an argument: user ID"}
echo "Input user ID: $managerID"
managerPW=${2:?"Requires an argumnet: manager PW"}
echo "Input manager PW: $managerPW"

location='/home/centos/Linker/CentOS7/'


###eGovRepository Setting###
wget http://175.114.128.46/publist/HDD1/public/mvnrepository_3.5.zip
mkdir ~/eGovRepository3_5
unzip ./mvnrepository_3.5.zip -d ~/eGovRepository3_5
mv ~/eGovRepository3_5/mvnrepository_3.5/* ~/eGovRepository3_5
rm -rf ~/eGovRepository3_5/mvnrepository_3.5
cp $location'settings.xml' ~/eGovRepository3_5/
sed -i "s/intruder/$managerID/g" ~/eGovRepository3_5/settings.xml
sed -i "s/tomcat7/$managerPW/g" ~/eGovRepository3_5/settings.xml
rm ./mvnrepository_3.5.zip
