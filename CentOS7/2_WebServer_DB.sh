#!/bin/bash


postgresPW='postgres'



###PostgreSQL 9.5.2 Isntall & Setting###
sudo yum install epel-release -y
sudo rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
sudo yum update -y
sudo yum install postgresql95 postgresql95-server pgadmin3 postgresql95-devel postgis2_95 postgis2_95-devel.x86_64 postgis2_95-utils.x86_64 postgis2_95-client -y

echo "-------------------------PostgreSQL init----------------------"
sudo /usr/pgsql-9.5/bin/postgresql95-setup initdb

echo "-------------------------Firewall Open : tcp port 5432--------"
sudo firewall-cmd --permanent --zone=public --add-port=5432/tcp  
sudo firewall-cmd --reload

echo "-------------------------External Access Privilege Settings---"
sudo sh -c "echo 'host	all	all	0.0.0.0/0	md5' >> /var/lib/pgsql/9.5/data/pg_hba.conf"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.5/data/postgresql.conf

echo "-------------------------Service register & password change---"
sudo systemctl enable postgresql-9.5.service
sudo service postgresql-9.5 start
echo "alter user postgres with password '$postgresPW'" | sudo su - postgres -c 'psql template1'


###Apache 2.4.2 Install & mod JK Setting###
sudo yum install httpd libtool httpd-devel apr apr-devel apr-util apr-util-devel
sudo systemctl enable httpd.service
sudo service start httpd
echo "-------------------------Firewall Open : tcp port 80---------"
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp  
sudo firewall-cmd --reload

echo "-------------------------Mod JK Install & Setting------------"
wget http://www.eu.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz
tar -xvf tomcat-connectors-1.2.41-src.tar.gz
sudo mv tomcat-connectors-1.2.41-src /opt/
rm tomcat-connectors-1.2.41-src.tar.gz

cd /opt/tomcat-connectors-1.2.41-src/native
./configure --with-apxs=/usr/bin/apxs
make
libtool --finish /usr/lib64/httpd/modules
sudo make install
sudo cp mod_jk.conf /etc/httpd/conf.d/
sudo mkdir -p /var/run/mod_jk
sudo chown apache:apache /var/run/mod_jk
sudo cp workers.properties /etc/httpd/conf/
sudo cp tomcatVirtualHost.conf  /etc/httpd/conf.d/
sudo semanage port -a -t http_port_t -p tcp 8010



