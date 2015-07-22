#!/bin/bash

#install 
apt-get install -y zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
git clone https://github.com/rupa/z

chsh
