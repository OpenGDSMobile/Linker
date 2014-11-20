##### PODS: Server Basic Environment Installation for Using the Public Open Data
-------------------------


download and uncompress
----------

donwload:

      wget https://github.com/OpenGDSMobile/Linker/archive/master.zip

uncompress:

      apt-get install -y unzip || unzip master.zip


setting
----------

vi ./Linker-master/setting

tomcat7 user name example     ---> user:admin    
tomcat7 user password example ---> passwd:temp321
...


ubuntu1x.04 (x ==> 2, 4)
----------

(root) or (sudo user)

cd ./Linker-master/ubuntu1x.04

./a_KERU.sh ----> Kernel Update and Reboot
./b_LIBI.sh ----> Libraries Installation
./c_TGAC.sh ----> Tomcat, GeoServer, Apache Web Server Configuration
./d_EGFS.sh ----> E-Government Framework Setting
