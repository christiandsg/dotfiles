dotfiles
========
Setup
-----------
* Clone repository (change the location if you wish)
```sh
git clone https://github.com/christiandsg/dotfiles.git .dotfiles
```
* Create config files
```sh
./setup_vim.sh
./setup_zsh.sh
```
* (only OSX) Change default shell to zsh
```sh
chsh -s /bin/zsh
```

Script list
-----------
* setup_vim.sh: Installs and configures common VIM plugins. At the moment really barebone (aka dumb) not configurable or extensible.
The main function is to avoid having to copy/paste configs accross machines and also to make a "clean" install without much trouble.
