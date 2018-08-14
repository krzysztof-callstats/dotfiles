#!/bin/bash

# Repo download and unzip
./scripts/prepare_repo.sh

source ./lib_sh/echos.sh
bot "Hi! I'm going to setup this machine. Here I go..."

# Configure git
./scripts/setup_git.sh

# Create symlinks
./scripts/symlink_dotfiles.sh

# Run script for specific platform
if [[ -f /etc/fedora-release ]]; then
  ./install_fedora.sh
elif [[ -f /etc/lsb-release ]]; then
  ./install_ubuntu.sh
else
  error "This setup script does not support your platform."
  exit 127;
fi
