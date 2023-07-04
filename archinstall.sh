#!/usr/bin/env bash

# Confirm that script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root(or sudo)"
  exit
fi

# WebSploitArch installation script
# Modified Script Author: @Martian1337

# Websploit Author: Omar Ωr Santos
# Web install (Debian): https://websploit.org
# Twitter: @santosomar

clear
echo "

██╗    ██╗███████╗██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗████████╗
██║    ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗██║╚══██╔══╝
██║ █╗ ██║█████╗  ██████╔╝███████╗██████╔╝██║     ██║   ██║██║   ██║
██║███╗██║██╔══╝  ██╔══██╗╚════██║██╔═══╝ ██║     ██║   ██║██║   ██║
╚███╔███╔╝███████╗██████╔╝███████║██║     ███████╗╚██████╔╝██║   ██║
 ╚══╝╚══╝ ╚══════╝╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝   ╚═╝
L A B S      B Y     O M A R   S A N T O S 

https://websploit.org
Author: Omar Ωr Santos
Twitter: @santosomar
Version: 3.2

A collection of tools, tutorials, resources, and intentionally vulnerable 
applications running in Docker containers. WebSploit Labs include 
over 500 exercises to learn and practice ethical hacking (penetration testing) skills.
--------------------------------------------------------------------------------------
"

read -n 1 -s -r -p "Press any key to continue the setup..."

echo " "

# Install necessary packages
sudo pacman -Syu --noconfirm
sudo pacman -S wget curl docker docker-compose git python-pip --noconfirm

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

echo "Getting docker-compose.yml from WebSploit.org"
wget https://websploit.org/docker-compose.yml

# Instantiating the containers with docker-compose
echo "Setting up the containers and internal bridge network"
docker-compose -f docker-compose.yml up -d

# Cloning NodeGoat
git clone https://github.com/OWASP/NodeGoat.git

# Replacing the docker-compose.yml file with my second bridge network (10.6.7.0/24)
curl -sSL https://websploit.org/nodegoat-docker-compose.yml > /root/NodeGoat/docker-compose.yml

# Downloading the nodegoat.sh script from websploit
# This will be used manually to setup the NodeGoat environment
wget https://websploit.org/nodegoat.sh
chmod 744 nodegoat.sh 

# Downloading API Gateway configuration
mkdir /opt/api_gateway
wget https://websploit.org/api_gateway/config.yml
mv config.yml /opt/api_gateway/.

# Getting IoTGoat and other IoT firmware for different exercises
cd /root
mkdir iot_exercises
cd iot_exercises
wget https://github.com/OWASP/IoTGoat/releases/download/v1.0/IoTGoat-raspberry-pi2.img
mv IoTGoat-raspberry-pi2.img firmware1.img

wget https://github.com/santosomar/DVRF/releases/download/v3/DVRF_v03.bin
mv DVRF_v03.bin firmware2.bin

#Getting the container info script
cd /root
curl -sSL https://websploit.org/containers.sh > /root/containers.sh

chmod +x /root/containers.sh
mv /root/containers.sh /usr/local/bin/containers 

#Final confirmation
sudo /usr/local/bin/containers
echo "
All set! All tools, apps, and containers have been installed and setup.
Have fun! - Ωr
"
