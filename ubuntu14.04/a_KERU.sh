#!/bin/bash


# --------------------------------------------- #
# a_KERU.sh ----------------------------------- #
# a_KERnel Update.sh -------------------------- #
# --------------------------------------------- #




##### locale setup =========================================================================== 
localeFile='/etc/default/locale'

sed -i "$ a\LANGUAGE=\"en_US.UTF-8\"\n\
LC_ALL=\"en_US.UTF-8\"\n\
LC_CTYPE=\"en_US.UTF-8\"\n\
LC_NUMERIC=\"en_US.UTF-8\"\n\
LC_TIME=\"en_US.UTF-8\"\n\
LC_MONETARY=\"en_US.UTF-8\"\n\
LC_PAPER=\"en_US.UTF-8\"\n\
LC_NAME=\"en_US.UTF-8\"\n\
LC_ADDRESS=\"en_US.UTF-8\"\n\
LC_TELEPHONE=\"en_US.UTF-8\"\n\
LC_MEASUREMENT=\"en_US.UTF-8\"\n\
LC_IDENTIFICATION=\"en_US.UTF-8\"\n\
" $localeFile
#=============================================================================================


sudo apt-get update
sudo apt-get install -y linux-headers-generic-lts-trusty linux-image-generic-lts-trusty
sudo apt-get update && apt-get upgrade -y
sudo reboot
