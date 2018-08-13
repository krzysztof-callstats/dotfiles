#!/bin/bash

# Sanity check
[ -f /etc/fedora-release ] || { error "This script if for Fedora"; exit 127; }

# Repo download and unzip
rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
cd /tmp/repo
curl -L https://github.com/devligue/dotfiles/archive/master.zip > repo.zip
sudo dnf -y install unzip
unzip repo.zip
rm repo.zip
mv dotfiles* ~/.dotfiles
cd ~/.dotfiles
rm -rf /tmp/repo

source ./lib_sh/echos.sh
bot "Hi! I'm going to setup this machine. Here I go..."

bot "Configuring git. I'm gonna need your help..."
grep 'user = GITHUBUSER' ./homedir/.gitconfig > /dev/null 2>&1
if [[ $? = 0 ]]; then
    read -r -p "What is your github.com username? " githubuser
    read -r -p "What is your first name? " firstname
    read -r -p "What is your last name? " lastname
    read -r -p "What is your email? " email
    fullname="$firstname $lastname"
    bot "Greatings $fullname, "
    sed -i "s/GITHUBFULLNAME/$firstname $lastname/" ./homedir/.gitconfig > /dev/null 2>&1
    sed -i 's/GITHUBEMAIL/'$email'/' ./homedir/.gitconfig
    sed -i 's/GITHUBUSER/'$githubuser'/' ./homedir/.gitconfig
fi

bot "Updating packages..."
sudo dnf -y update

bot "Installing python and other necessary tools"
sudo dnf install python-pip
sudo dnf install python3-pip
pip install --user neovim
pip3 install --user pipenv neovim flake8 black

bot "Installing neovim..."
dnf -y install neovim

bot "Creating symlinks for project dotfiles..."
pushd homedir > /dev/null 2>&1
now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  # if the file exists:
  if [[ -e ~/$file ]]; then
      inform "$file already exists"
      mkdir -p ~/.dotfiles_backup/$now
      mv ~/$file ~/.dotfiles_backup/$now/$file
      inform "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  running "unlink ~/$file > /dev/null 2>&1"
  unlink ~/$file > /dev/null 2>&1
  # create the link
  running "ln -s ~/.dotfiles/homedir/$file ~/$file"
  ln -s ~/.dotfiles/homedir/$file ~/$file
  ok "linking ${file}"
done

popd > /dev/null 2>&1


bot "Configuring bash..."
# mkdir -p ~/bin
grep 'source ~/.profile' ~/.bashrc || echo "source ~/.profile" >> ~/.bashrc
source ~/.bashrc

bot "Setting up neovim..."
sudo dnf install ctags
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim_runtime/bundle/Vundle.vim
nvim +PluginInstall +qall
