#!/bin/bash

# Repo download and unzip
DNF_CMD=$(which dnf)
YUM_CMD=$(which yum)
APT_CMD=$(which apt)

if [[ ! -z $DNF_CMD ]]; then
  sudo dnf install unzip
elif [[ ! -z $YUM_CMD ]]; then
  sudo yum install unzip
elif [[ ! -z $APT_GET_CMD ]]; then
  sudo apt install unzip
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
