#!/bin/bash

bot "Creating symlinks for project dotfiles..."
pushd homedir > /dev/null 2>&1
now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  # if the file exists:
  if [[ -e ~/$file ]]; then
      warn "$file already exists"
      mkdir -p ~/.dotfiles_backup/$now
      running mv ~/$file ~/.dotfiles_backup/$now/$file
      inform "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  running unlink ~/$file > /dev/null 2>&1
  # create the link
  running ln -s ~/.dotfiles/homedir/$file ~/$file
  ok "${file} linked"
done

popd > /dev/null 2>&1
