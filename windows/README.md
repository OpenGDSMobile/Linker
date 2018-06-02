#### How to install OpenGDS Mobile Application Server configuration in Windows 10 64bit

------

Pre-install software 

- Java JDK 1.7
  (http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
  !!!NECESSARY   JAVA_HOME setting  (Windows Environment Values)
- PostgreSQL 9.X
  (http://www.enterprisedb.com/products-services-training/pgdownload#windows)



Explanation

- 1_WebServer_DB.ps1

  > - Installation Apache web server
  > - Configuration PostgreSQL and Tomcat(Mod JK)

- 2_TomcatServer.ps1

  > - Tomcat download & configuration for OpenGDSMobile Application Server 
  > - Tomcat download & configuration for GeoServer(Data Server)
  > - GeoServer download & configuration



Install path

- C:\Servers\*



Usage

```console
vcredist_arm run (if you are not installed vc++ 2012 in windows)
Powershell run (Administrator mode)

PS ..>1_WebServer_DB.ps1

PS ..>2_TomcatServer.ps1
```