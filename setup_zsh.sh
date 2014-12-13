#!/bin/sh
# Simple script to setup zsh goodies

set -e

echo "#### ZSH Config Setup ####"

# Files to symlink
zshrc_config_files='.oh-my-zsh .zshrc.base .zshrc.functions'

recreate_symbolic_links(){
  echo "=======> Creating "
  for i in $zshrc_config_files; do
    echo "Recreating symbolic link '$i'"
    rm -rf ~/$i
    ln -s $PWD/$i ~/$i
  done
}

recreate_zshrc(){
  # Create ~/.zshrc as a copy since we might want to modify it.
  # TODO: Find a way to extend it (maybe a folder containing all zsh source files?)
  rm -f ~/.zshrc
  cp ~/.zshrc.base ~/.zshrc
}

# Commands
recreate_symbolic_links
recreate_zshrc
