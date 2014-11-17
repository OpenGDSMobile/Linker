#!/bin/bash

# --------------------------------------------- #
# c_TGAC.sh ----------------------------------- #
# c_Tomcat GeoServer Apache Configuration.sh -- #
# --------------------------------------------- #


bashrcFile="/etc/bash.bashrc"
sed -i '$ a\export JAVA_OPTS="-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"' $bashrcFile
