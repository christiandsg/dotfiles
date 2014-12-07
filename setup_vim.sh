#!/bin/sh
# Simple script to install vim plugins and its required configs
# More plugins here: http://vimawesome.com/

VIM_FOLDER=~/.vim
VIMRC=~/.vimrc

clear_vimrc(){
  echo "=======> Clearing .vim and .vimrc"
  rm -rf $VIM_FOLDER; rm $VIMRC
  mkdir $VIM_FOLDER; touch $VIMRC
}

get_base_vimrc(){
  echo "=======> Adding editor config to .vimrc"
  curl -LSso ~/.vimrc https://raw.githubusercontent.com/christiandsg/dotfiles/master/.vimrc.base
}

install_pathogen(){
  echo "=======> Installing vim-pathogen : https://github.com/tpope/vim-pathogen"
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  echo "\" === Plugin: vim-pathogen
execute pathogen#infect()
execute pathogen#helptags()
" >> $VIMRC
}

install_solarized(){
  echo "=======> Installing solarized : https://github.com/altercation/vim-colors-solarized"
  cd ~/.vim/bundle
  git clone git://github.com/altercation/vim-colors-solarized.git
  echo "\" === Colorscheme : Solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast=\"high\"
let g:solarized_visibility=\"high\"
colorscheme solarized
" >> $VIMRC
}

install_vim_airline(){
  echo "=======> Installing vim-airline : https://github.com/bling/vim-airline"
  cd ~/.vim/bundle
  git clone git://github.com/bling/vim-airline.git
  echo "\" === Plugin : Airline (status bar)
let g:airline_theme=\"powerlineish\"
" >> $VIMRC
}

install_nerdtree(){
  echo "=======> Installing NerdTree : https://github.com/scrooloose/nerdtree"
  cd ~/.vim/bundle
  git clone git://github.com/scrooloose/nerdtree.git
  echo "\" === Plugin : Nerdtree
nmap <F7> :NERDTreeToggle<CR>
nmap <F6> :NERDTreeMirror<CR>
" >> $VIMRC
}

install_vim_fugitive(){
  echo "=======> Installing vim-fugitive : https://github.com/tpope/vim-fugitive"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-fugitive.git
}

install_tagbar(){
  echo "=======> Installing tagbar : https://github.com/majutsushi/tagbar"
  cd ~/.vim/airline
  git clone git://github.com/majutsushi/tagbar.git
  echo "\" === Plugin : Tagbar
nmap <F8> :TagbarToggle<CR>
" >> $VIMRC
}

install_repeat_vim(){
  echo "=======> Installing repeat-vim : http://vimawesome.com/plugin/repeat-vim"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-repeat.git
}

# Text editing replated plugins
install_vim_surround(){
  echo "=======> Installing vim-surround : https://github.com/tpope/vim-surround.git"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-surround.git
}

install_tabular(){
  echo "=======> Installing tabular : https://github.com/godlygeek/tabular"
  cd ~/.vim/bundle
  git clone git://github.com/godlygeek/tabular.git
}

install_vim_unimpaired(){
  echo "=======> Installing vim-unimpaired : https://github.com/tpope/vim-unimpaired"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-unimpaired.git
}

# Ruby/Rails related plugins
install_vim_blunder(){
  echo "=======> Installing vim-blunder (rails): https://github.com/tpope/vim-blunder"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-bundler.git
}

install_vim_rails(){
  echo "=======> Installing vim-rails : https://github.com/tpope/vim-rails"
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-rails.git
}

# Check params are present
clear_vimrc
get_base_vimrc

install_pathogen

install_solarized
install_vim_airline
install_nerdtree
install_vim_fugitive
install_repeat_vim

install_vim_surround
install_tabular
install_vim_unimpairedi

install_vim_blunder
install_vim_rails
