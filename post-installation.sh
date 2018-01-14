#!/bin/bash

# Install packages
echo "(i) install packages"
sudo pacman -S - < pkglist.txt

# Set the keyboard layout settings
echo "(i) set the keyboard layout"
localectl set-x11-keymap fr

# Pull dotfiles
dotfiles_dir=$HOME/Documents/dotfiles
mkdir -p $dotfiles_dir
git clone https://github.com/cboin/dotfiles $dotfiles_dir

# Set bash config
echo "(i) set bash config"
ln -sf $dotfiles_dir/config_files/bash/bashrc $HOME/.bashrc 

# Set i3wm config
echo "(i) set i3wm config"
ln -sf $dotfiles_dir/config_files/i3wm/config $HOME/.config/i3/config 
ln -sf $dotfiles_dir/config_files/i3wm/i3status.conf $HOME/.config/i3/i3status.conf 
sudo wget http://static.simpledesktops.com/uploads/desktops/2015/02/20/zentree_1.png -O /usr/share/pixmaps/wallpaper.png
sudo wget http://raspberrypi.windowswiki.info/img/archlinuxlogo.png -O /usr/share/pixmaps/arch-logo.png
ln -sf $dotfiles_dir/config_files/i3wm/lock.sh $HOME/.config/i3/lock.sh
sudo ln -sf $HOME/.config/i3/lock.sh /usr/bin/lock
chmod +x /usr/bin/lock

# Set X11 config
echo "(i) set X11 config"
ln -sf $dotfiles_dir/config_files/X11/Xresources $HOME/.Xresources 
ln -sf $dotfiles_dir/config_files/X11/xinitrc $HOME/.xinitrc 

# Set lightdm config
echo "(i) set lightdm config"
sudo ln -sf $dotfiles_dir/lightdm/* /etc/lightdm/

# Set git config
echo "(i) set git config"
ln -sf $dotfiles_dir/config_files/git/gitconfig $HOME/.gitconfig

# Set vim config
echo "(i) set vim config"
ln -sf $dotfiles_dir/config_files/vim/vimrc $HOME/.vimrc
ln -sf $dotfiles_dir/vim $HOME/.vim
