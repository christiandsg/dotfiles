#!/bin/sh
# Simple script to install vim plugins and its required configs
# More plugins here: http://vimawesome.com/

VIM_FOLDER=~/.vim
VIMRC=~/.vimrc

update_git_submodules(){
  echo "=======> Updating Git submodules"
  git submodule init   &> /dev/null
  git submodule update &> /dev/null
}

clear_vim_configs(){
  echo "=======> Creating simbolic link to .vim"
  rm -rf $VIM_FOLDER
  ln -s $PWD/.vim $VIM_FOLDER
  echo "=======> Clearing .vimrc"
  rm $VIMRC
  touch $VIMRC
}

get_base_vimrc(){
  echo "=======> Adding editor config to .vimrc"
  curl -LSso ~/.vimrc https://raw.githubusercontent.com/christiandsg/dotfiles/master/.vimrc.base
}

install_pathogen(){
  echo "=======> Installing vim-pathogen : https://github.com/tpope/vim-pathogen"
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  echo "\" === Plugin: vim-pathogen
execute pathogen#infect()
execute pathogen#helptags()
" >> $VIMRC
}

config_solarized(){
  echo "=======> Installing solarized : https://github.com/altercation/vim-colors-solarized"
  echo "\" === Colorscheme : Solarized
set background=dark
let g:solarized_termtrans=1
\"let g:solarized_termcolors=256
let g:solarized_contrast=\"high\"
let g:solarized_visibility=\"high\"
colorscheme solarized
" >> $VIMRC
}

config_vim_airline(){
  echo "=======> Installing vim-airline : https://github.com/bling/vim-airline"
  echo "\" === Plugin : Airline (status bar)
let g:airline_theme=\"powerlineish\"
" >> $VIMRC
}

config_nerdtree(){
  echo "=======> Installing NerdTree : https://github.com/scrooloose/nerdtree"
  echo "\" === Plugin : Nerdtree
nmap <F7> :NERDTreeToggle<CR>
nmap <F6> :NERDTreeMirror<CR>
" >> $VIMRC
}

config_tagbar(){
  echo "=======> Installing tagbar : https://github.com/majutsushi/tagbar"
  echo "\" === Plugin : Tagbar
nmap <F8> :TagbarToggle<CR>
" >> $VIMRC
}

# Commands
update_git_submodules
clear_vim_configs
get_base_vimrc

install_pathogen

config_solarized
config_vim_airline
config_nerdtree
config_tagbar
