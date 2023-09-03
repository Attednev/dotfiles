#!/bin/bash

CWD=$(pwd)
USER=$(whoami)

echo "> Starting installation"

echo "> Installing all required packages"
sudo pacman -Syy --noconfirm gtk3 kitty xdg-desktop-portal-hyprland dunst qt5-wayland qt6-wayland hyprpaper swaylock pavucontrol lxappearance thunar brightnessctl pulseaudio network-manager-applet ttf-font-awesome fish qt5ct fisher sddm 
echo "> Finished"

echo "> Installing yay"
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -r $USER:$USER yay-git
cd yay-git
makepkg -si --noconfirm
echo "> Finished"

echo "> Installing AUR packages"
yay -Syy --noconfirm hyprland-git waybar-hyprland-git
echo "> Finished"
