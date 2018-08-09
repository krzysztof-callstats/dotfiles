#!/bin/bash

# Sanity check
[ -f /etc/fedora-release ] || { error "This script if for Fedora"; exit 127; }

rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
cd /tmp/repo
curl -L https://github.com/devligue/dotfiles/archive/master.zip > repo.zip
sudo yum -y install unzip
unzip repo.zip
rm repo.zip
mv dotfiles* ~/.dotfiles
cd ~/.dotfiles
rm -rf /tmp/repo
bash setup_fedora.sh
