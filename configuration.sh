#!/bin/bash

CWD=$(pwd)
TIME=$(date +%Y.%m.%d-%H.%M.%S)
SDDMIMAGE="https://r4.wallpaperflare.com/wallpaper/264/666/478/3-316-16-9-aspect-ratio-s-sfw-wallpaper-7910883d41aafdcb36f7487fb0f1964d.jpg"

echo "> Starting configuration"

echo "> Creating backup"
cd "$HOME" || exit
cp -r .config .config-"$TIME"
cp -r .local .local-"$TIME"
echo "> Finished"

echo "> Changing sddm theme"
sudo cp "$CWD"/etc/sddm.conf /etc/sddm.conf
sudo cp -r "$CWD"/usr /
curl "$SDDMIMAGE" | sudo tee /usr/share/sddm/themes/custom/background.jpg
echo "> Finished"

echo "> Copying files"
cp -r "$CWD"/.config "$HOME"
cp -r "$CWD"/.local "$HOME"
echo "> Finished"

echo "> Linking background-images"
sudo rm -r /usr/share/wallpapers
sudo ln -s "$HOME"/.local/share/background-images/ /usr/share/wallpapers
echo "> Finished"

echo "> Changing shell"
chsh -s /bin/fish
echo "> Finished"

echo "> Changing GTK theme"
mkdir -p "$HOME"/.themes/
cd "$HOME"/.themes || exit
git clone https://github.com/dracula/gtk.git Dracula
gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'
gsettings set org.gnome.desktop.wm.preferences theme 'Dracula'
echo "> Finished"

echo "> Changing fish theme"
fisher install dracula/fish
echo "> Finished"

echo "> Changing qt5 theme"
mkdir -p "$HOME"/.config/qt5ct/colors
curl https://raw.githubusercontent.com/dracula/qt5/master/Dracula.conf > "$HOME"/.config/qt5ct/colors/Dracula.conf
echo "> Finished"


