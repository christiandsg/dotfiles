#!/bin/sh
# Simple script to setup assorted dotfiles

set -e

echo "#### Assorted dotfiles configs ####"

# Files to symlink
dotfiles='.gitconfig .global_gitignore'

recreate_symbolic_links(){
  echo "=======> Creating assorted dotfiles configs"
  for i in $dotfiles; do
    echo "Recreating symbolic link '$i'"
    rm -rf ~/$i
    ln -s $PWD/$i ~/$i
  done
}

# Commands
recreate_symbolic_links
