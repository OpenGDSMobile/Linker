##### Linker: Basic Environment Installation Scripts of OpenGDS Mobile Application Server
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


ubuntu1x.04 (x == 2, 4)
----------

(root) or (sudo user)

      cd ./Linker-master/ubuntu1x.04
      
      ## Kernel Update and Reboot
      ./a_KERU.sh 
      
      ## Libraries Installation
      ./b_LIBI.sh 
      
      ## Tomcat, GeoServer, Apache Web Server Configuration
      ./c_TGAC.sh 
      
      ## E-Government Framework Setting
      ./d_EGFS.sh
