#!/bin/sh
# Simple script to setup zsh goodies

set -e

echo "#### ZSH Config ####"

HOME_ZSH=~/.oh-my-zsh
HOME_ZSHRC=~/.zshrc

clear_zsh_configs(){
  echo "=======> Creating simbolic link to .oh-my-zsh"
  rm -rf $HOME_ZSH
  ln -s $PWD/.oh-my-zsh $HOME_ZSH
  echo "=======> Clearing .zshrc"
  rm $HOME_ZSHRC
  touch $HOME_ZSHRC
}

get_base_zshrc(){
  echo "=======> Pulling base .zshrc"
  curl -LSso $ZSHRC https://raw.githubusercontent.com/christiandsg/dotfiles/master/.zshrc.base
}

# Commands
clear_zsh_configs
get_base_zshrc
