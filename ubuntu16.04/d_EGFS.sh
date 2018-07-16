#!/bin/bash

echo "Input Manager ID: "
read Manager_ID
echo "Input Manager Password: "
read Manager_Passwd

# eGovRepository Setting==================================================
wget http://175.114.128.46/publist/HDD1/public/mvnrepository_3.5.zip
mkdir ./eGovRepository3_5
unzip ./mvnrepository_3.5.zip -d ./eGovRepository3_5
mv ./eGovRepository3_5/mvnrepository_3.5/* ./eGovRepository3_5
rm -rf ./eGovRepository3_5/mvnrepository_3.5
cp ./settings.xml ./eGovRepository3_5/

sed -i "s/\/home\/intruder\//\/home\/$USER\//g" ./eGovRepository3_5/settings.xml
sed -i "s/intruder/$Manager_ID/g" ./eGovRepository3_5/settings.xml
sed -i "s/tomcat7/$Manager_Passwd/g" ./eGovRepository3_5/settings.xml

mv ./eGovRepository3_5 /home/$USER/
rm ./mvnrepository_3.5.zip
