#!/bin/sh

# Add TouchID as sudo authentication method

csr=$(csrutil status | /usr/local/bin/rg -o enabled)

if [[ -z $csr ]]; then
  touch ./sudo
  sudo sed $'2i\\\nauth       sufficient     pam_tid.so\n' /etc/pam.d/sudo > ./sudo
  sudo chmod -w ./sudo
  sudo chown root ./sudo
  sudo mv /etc/pam.d/sudo /etc/pam.d/sudo~
  sudo mv ./sudo /etc/pam.d/sudo
else
  echo 'CSR is NOT disabled'
fi
