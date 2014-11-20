#!/bin/bash

# -------------------------------------- #
# d_EGFS.sh ---------------------------- #
# d_E-Government Framework Setting.sh -- #
# -------------------------------------- #


#### init setup    ====================================================================================
settingFilename="../setting"
egovFrameworkLocation="" 

while read line
do
  IFS=': ' read -a array <<< $line

  if [ ${array[0]} == "eGovFrameworkLocation" ]; then
    egovFrameworkLocation=${array[1]}
    echo $egovFrameworkLocation 
  fi 
done < $settingFilename
#======================================================================================================


#### e-government Framework Donwload ================================================================== 

# e-gov download --------------------------------------------------------------------------------------
mkdir -p $egovFrameworkLocation
mkdir -p ./downloads/egovframe

wget http://175.114.128.46/publist/HDD1/public/mvnrepository_3.0.zip \
     -O ./downloads/egovframe/mvnrepository_3.0.zip
unzip ./downloads/egovframe/mvnrepository_3.0.zip -d $egovFrameworkLocation
#------------------------------------------------------------------------------------------------------


# e-gov maven setting ---------------------------------------------------------------------------------
cp ../v_egovMavenSettingXml/settings.xml $egovFrameworkLocation

egovMavenSettingXml="settings.xml"
egovMavenSettingXmlFile=$egovFrameworkLocation$egovMavenSettingXml

sed -i -e 's#egovMavenRepositoryDirectory#'$egovFrameworkLocation'#g' $egovMavenSettingXmlFile
#------------------------------------------------------------------------------------------------------

#======================================================================================================






