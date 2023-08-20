#!/bin/bash

CWD=$(pwd)

# Copy all dotfiles
# TODO

# Link wallpaper folder
sudo rm -r /usr/share/wallpapers
sudo ln -s $HOME/.local/share/background-images/ /usr/share/wallpapers

# Change shell to fish
chsh -s /bin/fish

# Install Mousepad dracula theme
cd /tmp
git clone https://github.com/dracula/mousepad.git
cd mousepad
mkdir -p $HOME/.local/share/gtksourceview-4/styles
cp dracula.xml $HOME/.local/share/gtksourceview-4/styles

# Set Mousepad settings
mkdir -p $HOME/.local/share/Mousepad
config="$CWD/.local/share/Mousepad/mousepad.conf"
while IFS= read -r line; do
	gsettings set $line
done < $config

# Install dracula gtk theme
mkdir -p $HOME/.themes/
cd $HOME/.themes
git clone https://github.com/dracula/gtk.git
gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
gsettings set org.gnome.desktop.wm.preferences theme 'Dracula'

# Install dracula fish theme
fisher install dracula/fish

# Install dracula qt5 theme
mkdir -p $HOME/.config/qt5ct/colors
curl https://raw.githubusercontent.com/dracula/qt5/master/Dracula.conf > $HOME/.config/qt5ct/colors/Dracula.conf
