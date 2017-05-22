Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy Unrestricted

mkdir tmp
function Expand-ZIPFile($file, $destination){
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace($file)
	foreach($item in $zip.items()){
		$shell.Namespace($destination).copyhere($item)
	}
}
$curLocation = pwd
$destLocation = $curLocation.path + "\tmp"
#### Database Install
add-content -path "C:\Program Files\PostgreSQL\9.5\data\pg_hba.conf" -value "host`t all `t all `t 0.0.0.0/0 `t md5"
net stop postgresql-x64-9.5
net start postgresql-x64-9.5


#### Web Server Install 
wget http://www.apachehaus.com/downloads/httpd-2.4.20-x64-vc11-r2.zip -OutFile .\tmp\Apache-2.4.20.zip
mkdir C:\Servers
$zipLocation = $curLocation.path + "\tmp\Apache-2.4.20.zip"
$zipLocation
Expand-ZIPFile -File $zipLocation -destination "C:\Servers\"
robocopy ".\" "C:\Servers\Apache24\conf" "httpd.conf"
robocopy ".\" "C:\Servers\Apache24\conf" "mod_jk.conf"
robocopy ".\" "C:\Servers\Apache24\conf" "workers.properties"
wget https://archive.apache.org/dist/tomcat/tomcat-connectors/jk/binaries/windows/tomcat-connectors-1.2.40-windows-x86_64-httpd-2.4.x.zip -OutFile ".\tmp\tomcat-connectors-1.2.40.zip"

$zipLocation = $curLocation.path + "\tmp\tomcat-connectors-1.2.40.zip"
$destLocation = $curLocation.path + "\tmp\tomcat-connectors-1.2.40"
mkdir $destLocation
Expand-ZIPFile -File $zipLocation -destination $destLocation

#### mod jk... 
cp $destLocation"\mod_jk.so" c:\Servers\Apache24\modules


C:\Servers\Apache24\bin\httpd.exe -k install
C:\Servers\Apache24\bin\httpd.exe -k start
