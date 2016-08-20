Set-ExecutionPolicy Unrestricted

function Expand-ZIPFile($file, $destination){
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace($file)
	foreach($item in $zip.items()){
		$shell.Namespace($destination).copyhere($item)
	}
}
mkdir tmp
$curLocation = pwd
$destLocation = $curLocation.path + "\tmp"

#$id = Read-host "Input Tomcat Manager ID:"
#$pw = Read-host "Input Tomcat Manager PASSWORD:"


$outputFolderName = "apache-tomcat-8.0.36"
$outputFolder = "tmp\" + $outputFolderName
$outputZipFile = ".\tmp\" + $outputFolderName + ".zip" 
wget http://mirror.apache-kr.org/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36-windows-x64.zip -OutFile $outputZipFile
$zipLocation = $curLocation.path + "\tmp\" + $outputFolderName +".zip"

Expand-ZIPFile -File $zipLocation -destination $destLocation

robocopy $outputFolder "C:\Servers\ApplicationServer" /E
robocopy $outputFolder "C:\Servers\DataServer" /E

###Application Server Setting
###DataServer Setting
robocopy ".\" "C:\Servers\ApplicationServer\conf" "tomcat-users.xml"
robocopy ".\" "C:\Servers\DataServer\conf" "tomcat-users.xml"


robocopy ".\" "C:\Servers\ApplicationServer\conf" "server_AS.xml"
rm C:\Servers\ApplicationServer\conf\server.xml
rename-item -path C:\Servers\ApplicationServer\conf\server_AS.xml -newname C:\Servers\ApplicationServer\conf\server.xml

robocopy ".\" "C:\Servers\DataServer\conf" "server.xml"

$outputZipFile = ".\tmp\jenkins.war" 
wget http://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/war-stable/1.651.1/jenkins.war  -OutFile $outputZipFile
robocopy ".\tmp" "C:\Servers\ApplicationServer\webapps" "jenkins.war"



$outputFolder = "geoserver-2.7.6-war"
$outputZipFile = ".\tmp\" + $outputFolder + ".zip" 
Invoke-WebRequest -Uri https://sourceforge.net/projects/geoserver/files/GeoServer/2.7.6/geoserver-2.7.6-war.zip  -OutFile $outputZipFile -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
$zipLocation = $curLocation.path + "\tmp\" + $outputFolder +".zip"
Expand-ZIPFile -File $zipLocation -destination $destLocation

robocopy ".\tmp" "C:\Servers\DataServer\webapps" "geoserver.war"

robocopy ".\" "C:\Servers\ApplicationServer\bin" "service_AS.bat"
rm C:\Servers\ApplicationServer\bin\service.bat
rename-item -path C:\Servers\ApplicationServer\bin\service_AS.bat -newname C:\Servers\ApplicationServer\bin\service.bat
C:\Servers\ApplicationServer\bin\service.bat install ApplicationServer8


robocopy ".\" "C:\Servers\DataServer\bin" "service.bat"
C:\Servers\DataServer\bin\service.bat install DataServer8

Restart-Service ApplicationServer8,DataServer8

    
