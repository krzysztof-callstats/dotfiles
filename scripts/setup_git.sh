#!/bin/bash

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
