#!/bin/bash

# Sanity check
[ -f /etc/fedora-release ] || { error "This script if for Fedora"; exit 127; }

bot "Updating packages..."
running sudo dnf -y update

bot "Installing python and other necessary tools"
running sudo dnf install python-pip
running sudo dnf install python3-pip
running pip install --user neovim
running pip3 install --user pipenv neovim flake8 black

bot "Configuring bash..."
# Install fzf
running git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
running ~/.fzf/install
# Install ag
running sudo dnf install the_silver_searcher -y
# Add "source ~/.profile" to .bashrc if it does not exists
running grep "source ~/.profile" ~/.bashrc || echo "source ~/.profile" >> ~/.bashrc

bot "Setting up neovim..."
# Install NeoVIM
running sudo dnf -y install neovim
# Make sure exuberant ctags are installed
running sudo dnf install ctags
# Install Vundle.vim plugin manager
running git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim_runtime/bundle/Vundle.vim
# Install nvim plugins
running nvim +PluginInstall +qall
