#!/bin/bash


###user name setup ###
userName=${1:?"Requires an argument: user ID"}
echo "Input user ID: $userName"
str="$userName	ALL=(ALL)	NOPASSWD:ALL"
echo $str>tomcatUser

###Sudo user privileges acquired###
su -c "cp tomcatUser /etc/sudoers.d/"


###Zsh install ###
sudo yum update -y
sudo yum install zsh git wget maven ant ant-junit unzip firewalld -y
sudo systemctl unmask firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
sed -i 's/robbyrussell/dieter/g' ~/.zshrc
echo "Please after su login, show New shell [/bin/bash]:   wrtie --> /bin/zsh"
su -c "chsh $userName"
/bin/zsh


###JDK 1.7.0.101 install and setting ###
sudo yum install java-1.7.0-openjdk-1.7.0.101 java-1.7.0-openjdk-devel-1.7.0.101 -y
sudo rm -rf /etc/alternatives/java
sudo ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.101-2.6.6.1.el7_2.x86_64/jre/bin/java /etc/alternatives/java



