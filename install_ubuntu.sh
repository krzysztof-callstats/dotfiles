#!/bin/bash

# Sanity check
[ -f /etc/lsb-release ] || { error "This script if for Ubuntu"; exit 127; }

bot "Configuring system repository..."
running sudo apt-get install software-properties-common
running sudo apt-add-repository ppa:neovim-ppa/stable

bot "Updating packages..."
running sudo apt-get update

bot "Installing python and other necessary tools"
running sudo apt install python-pip
running sudo apt install python3-pip
running pip install --user neovim
running pip3 install --user pipenv neovim flake8 black

bot "Configuring bash..."
# Install fzf
running git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
running ~/.fzf/install
# Install ag
running sudo apt-get install silversearcher-ag
# Add "source ~/.profile" to .bashrc if it does not exists
running grep "source ~/.profile" ~/.bashrc || echo "source ~/.profile" >> ~/.bashrc

bot "Setting up neovim..."
# Install NeoVIM
running sudo apt-get install neovim
# Make sure exuberant ctags are installed
running sudo apt install exuberant-ctags
# Install Vundle.vim plugin manager
running git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim_runtime/bundle/Vundle.vim
# Install nvim plugins
running nvim +PluginInstall +qall
# Build YouCompleteMe
running sudo apt-get install build-essential cmake -y
running sudo apt-get install python-dev python3-dev
cd ~/.vim/bundle/YouCompleteMe
# for go add: --go-completer
# for js add: --js-completer
running ./install.py --clang-completer
