#!/bin/bash

# Repo download and unzip
DNF_CMD=$(which dnf)
YUM_CMD=$(which yum)
APT_CMD=$(which apt)

UNZIP_CMD=${which unzip}

if [[ ! -z $DNF_CMD ]]; then
  sudo dnf install unzip
elif [[ ! -z $YUM_CMD ]]; then
  sudo yum install unzip
elif [[ ! -z $APT_CMD ]]; then
  sudo apt install unzip
elif [[ ! -z $UNZIP_CMD ]]; then
  echo "unzip already installed!"
else
  echo "error can't install package unzip"
  exit 1;
fi

rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
cd /tmp/repo
curl -L https://github.com/devligue/dotfiles/archive/master.zip > repo.zip
unzip repo.zip
rm repo.zip
cd dotfiles*
mkdir -p ~/.dotfiles
cp -a . ~/.dotfiles
cd ~/.dotfiles
rm -rf /tmp/repo

source ./lib_sh/echos.sh
bot "Hi! I'm going to setup this machine. Here I go..."

# Configure git
source ./scripts/setup_git.sh

# Create symlinks
source ./scripts/symlink_dotfiles.sh

# Run script for specific platform
if [[ -f /etc/fedora-release ]]; then
  source ./install_fedora.sh
elif [[ -f /etc/lsb-release ]]; then
  source ./install_ubuntu.sh
else
  error "This setup script does not support your platform."
  exit 127;
fi

bot "Everything done! Please reboot, so that everything works correctly"
