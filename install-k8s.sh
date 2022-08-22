#!/bin/bash

#######################################
# My script to install Kubernetes with AWS
# Made by Maksim Kulikov, 2022
#######################################

# COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

   exec 2>logs+errors
echo -e "$Cyan \n Install root priviliges for selected user? $Color_Off"
  echo "1 - yes, 2 - no"
  read rootx
  case $rootx in
   1)
   sleep 2
   echo -e "$Yellow \n Enter your username for root!!!: $Color_Off"
   read -p "Username Root: " user
   sudo usermod -aG sudo $user ;;
   2)
   echo -e "$Red \n aborted $Color_Off"
   sleep 1 ;;
   *)
   echo -e "$Red \n error $Color_Off"
   sleep 1
   esac

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

# Install cli
echo -e "$Cyan \n Updating AWSCLI.. $Color_Off"
sudo apt install awscli --upgrade

# Kubernetes path
echo -e "$Red \n Enter path to install kubernetes (example /etc/kubernetes/).. $Color_Off"
read -p "Enter path to install kubernetes (example /etc/kubernetes/): " dir
sleep 2
echo -e "$Red \n DONE $Color_Off"
sudo mkdir $dir
sleep 1
echo -e "$Cyan \n Create path. Wait... $Color_Off"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl $dir

echo -e "$Cyan \n Begin install kube $Color_Off"
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

echo -e "$Cyan \n Change priviliges $Color_Off"
sudo chmod +x kubectl
     >&2
sleep 2
echo "all done"
