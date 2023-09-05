#!/bin/bash

USER=$(whoami)

echo "> Starting installation"

echo "> Installing all required packages"
sudo pacman -Syy --noconfirm gtk3 kitty xdg-desktop-portal-hyprland dunst qt5-wayland qt6-wayland hyprpaper pavucontrol lxappearance thunar brightnessctl pulseaudio network-manager-applet ttf-font-awesome fish qt5ct fisher sddm wofi mpv grim slurp xclip qt5-graphicaleffects curl
echo "> Finished"

echo "> Installing yay"
cd /opt || exit
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R "$USER":"$USER" yay-git
cd yay-git ||  exit
makepkg -si --noconfirm
echo "> Finished"

echo "> Installing mpvpaper"
cd /opt || exit
sudo git clone --single-branch https://github.com/GhostNaN/mpvpaper
sudo chown -R "$USER":"$USER" yay-git
cd mpvpaper ||  exit
meson build --prefix=/usr/local
ninja -C build
ninja -C build install
echo "> Finished"

echo "> Installing AUR packages"
yay -Syy --noconfirm hyprland-git waybar-hyprland-git swaylock-effects-git
echo "> Finished"

echo "> Enabling sddm"
sudo systemctl enable sddm.service
echo "> Finished"
