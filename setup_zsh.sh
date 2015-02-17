#!/bin/sh
# Simple script to setup zsh goodies

set -e

echo "#### ZSH Config Setup ####"

ZHRC=~/.zshrc

# Files to symlink
zshrc_config_files='.oh-my-zsh'
zshrc_extras_files='.zshrc.functions .zshrc.aliases'

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
  mv -f $ZHRC ~/.zshrc.bak
  cp $PWD/.zshrc.base $ZHRC
}

add_extras_to_zshrc(){
  echo "## Automatically generated by setup_zsh.sh" >> $ZHRC
  echo "=======> Creating "
  for i in $zshrc_extras_files; do
    echo "Recreating symbolic link '$i'"
    rm -rf ~/$i
    ln -s $PWD/$i ~/$i
    echo "source ~/$i" >> $ZHRC
  done
  echo "##" >> $ZHRC
}

# Commands
recreate_symbolic_links
recreate_zshrc
add_extras_to_zshrc
