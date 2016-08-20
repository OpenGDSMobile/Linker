##### CentOS Linker Manual
-------------------------

Manual
----------

$cd ./Linker-1.2/CentOS7
step by step (1~5)

	## Update & sudo setting (require root password)
	$1_presets.sh {user id}

	## Apache web server(includ mod_jk) & postgreSQL install
	$2_WebServer_DB.sh

	## ApplicationServer container install (Tomcat 8)
	## Input values are user about tomcat manager
	$3_ApplicationServer.sh {tomcat user id} {tomcat user password}

	## DataServer container install (Tomcat 8)
	## Input values are user about tomcat manager
	$./4_DataServer.sh {tomcat user id} {tomcat user password}

	## Download & setting about eGovReposity files about maven 
	## (require Application Server tomcat user information)
	$./5_eGovRepo.sh {tomcat user id} {tomcat user password}

