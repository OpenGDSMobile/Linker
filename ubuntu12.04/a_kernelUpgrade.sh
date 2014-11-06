#!/bin/bash

sudo apt-get update
sudo apt-get install -y linux-headers-generic-lts-trusty linux-image-generic-lts-trusty
sudo apt-get update && apt-get upgrade -y
sudo reboot
