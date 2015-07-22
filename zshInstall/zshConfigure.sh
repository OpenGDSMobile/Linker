#!/bin/bash

#configure 
zshrcFile="$HOME/.zshrc"

currentLocation=$PWD
new=". $currentLocation/z/z.sh"
sed -i "$ a\
$new" $zshrcFile

old="robbyrussell"
new="dieter"
sed -i "s/$old/$new/g" $zshrcFile

