#!/usr/bin/env bash

# Add TouchID as sudo authentication method
touch ./sudo
sudo sed $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo > ./sudo
sudo chmod -w ./sudo
sudo chown root ./sudo
sudo mv /etc/pam.d/sudo /etc/pam.d/sudo~
sudo mv ./sudo /etc/pam.d/sudo
