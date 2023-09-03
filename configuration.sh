#!/bin/bash

CWD=$(pwd)
USER=$(whoami)
TIME=$(date +%Y.%m.%d-%H.%M.%S)

echo "> Starting configuration"

echo "> Creating backup"
cd $HOME
cp -r .config .config-$TIME
cp -r .local .local-$TIME
echo "> Finished"

echo "> Copying files"
cp -r $CWD/.config $HOME
cp -r $CWD/.local $HOME
echo "> Finished"

echo "> Linking background-images"
sudo rm -r /usr/share/wallpapers
sudo ln -s $HOME/.local/share/background-images/ /usr/share/wallpapers
echo "> Finished"

echo "> Changing shell"
chsh -s /bin/fish
echo "> Finished"

echo "> Changing GTK theme"
mkdir -p $HOME/.themes/
cd $HOME/.themes
git clone https://github.com/dracula/gtk.git Dracula
gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
gsettings set org.gnome.desktop.wm.preferences theme 'Dracula'
echo "> Finsihed"

echo "> Changing fish theme"
fisher install dracula/fish
echo "> Finished"

echo "> Changing qt5 theme"
mkdir -p $HOME/.config/qt5ct/colors
curl https://raw.githubusercontent.com/dracula/qt5/master/Dracula.conf > $HOME/.config/qt5ct/colors/Dracula.conf
echo "> Finished"


