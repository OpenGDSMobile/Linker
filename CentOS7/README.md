#### How to install OpenGDS Mobile Application Server configuration in CentOS 7
-------------------------

Explanation

- 1_persets.sh

  > - Related libraries and softwares installation
  > - List
  >   1. Zsh 
  >   2. Java
  >   3. git 
  >   4. wget
  >   5. maven 
  >   6. ant
  >   7. firewalld

- 2_webServer_DB.sh

  > - Web Server installation and configuration 
  > - List
  >   1. Apache web server
  >   2. postgresql
  >   3. modJK

- 3_applicationServer.sh

  > - Tomcat download & configuration for OpenGDSMobile Application Server 
  > - Jenkins download & configuration

- 4_dataServer.sh

  > - Tomcat download & configuration for GeoServer(Data Server)
  > - GeoServer download & configuration

- 5_eGovRepo.sh

  > - eGovframework Repository download & configuration in Korea.



Usage

 ```console
$cd CentOS7

$./1_presets.sh [USER_ID]	#Change [USER_ID] to your actual ID.

$./2_webServer_DB.sh

$./3_applicationServer.sh [TOMCAT_USER_ID] [TOMCAT_USER_PASSWORD]  #Change 
[TOMCAT_USER_ID] and [TOMCAT_USER_PASSWORD] to use as a Tomcat manager in the future 
about Application Server

$./4_dataServer.sh [TOMCAT_USER_ID] [TOMCAT_USER_PASSWORD]  #Change [TOMCAT_USER_ID] and [TOMCAT_USER_PASSWORD] to use as a Tomcat manager in the future about Data Server

$./5_eGovRepo.sh [TOMCAT_USER_ID] [TOMCAT_USER_PASSWORD] #Change [TOMCAT_USER_ID] and [TOMCAT_USER_PASSWORD] to your Application Server actual Infomation.
  (option - If you need further development, do it)
 ```