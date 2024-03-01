#!/bin/bash

installation_path=$(pwd)
themes_path="/home/$USER/.themes"

mkdir -p themes_path

# Install needed packages
sudo pacman -S --noconfirm foot papirus-icon-theme chromium git base-devel ufw discord timeshift noto-fonts-emoji ttf-nerd-fonts-symbols stow

# Stow
rm .config/kglobalshortcutsrc
rm .config/plasma-org.kde.plasma.desktop-appletsrc
rm .gtkrc-2.0
stow .

# Install sddm theme
cd themes_path
git clone https://github.com/catppuccin/sddm catppuccin-sddm
sudo cp -r /opt/catppuccin-sddm/src/catppuccin-mocha /usr/share/sddm/themes/catppuccin-mocha
sudo sed -i 's/^Current=.*/Current=catppuccin-mocha/' /etc/sddm.conf.d/kde_settings.conf
sudo systemctl restart sddm

# Install grub theme
cd /themes_path
git clone https://github.com/vinceliuice/grub2-themes grub-theme
cd grub-theme
sudo ./install.sh -b -t vimix

# Setup firewall
sudo ufw default deny
sudo ufw enable

# Run timeshift for configuration
sudo timeshift-gtk

# Install yay
cd ~
git clone https://aur.archlinux.org/yay.git yay
cd yay
makepkg -si --noconfirm

# Install kde theme
cd themes_path
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde
./catppuccin-kde/install < $installation_path/catppuccin-kde-options
/usr/lib/plasma-apply-colorscheme CatppuccinMochaBlue

# Set icon theme
/usr/lib/plasma-changeicons Papirus-Dark

# Install cursor, gtk and additional folder theme, as well as betterdiscord installer
yay -S --noconfirm catppuccin-cursors-mocha catppuccin-gtk-theme-mocha papirus-folders-catppuccin-git betterdiscord-installer
/usr/lib/plasma-apply-cursortheme Catppuccin-Mocha-Light-Cursors
papirus-folders -C cat-mocha-blue

# Install foot theme
cd themes_path
git clone https://github.com/catppuccin/foot catppuccin-foot
echo -e "\n[main]\ninclude=$HOME/catppuccin-foot/catppuccin-mocha.ini" >> ~/.config/foot/foot.ini

# Set virtual desktops (number and names)
kwriteconfig5 --file kwinrc --group Desktops --key Number 4
kwriteconfig5 --file kwinrc --group Desktops --key Name_1 "I"
kwriteconfig5 --file kwinrc --group Desktops --key Name_2 "II"
kwriteconfig5 --file kwinrc --group Desktops --key Name_3 "II"
kwriteconfig5 --file kwinrc --group Desktops --key Name_4 "IV"

# Set task switcher layout
kwriteconfig5 --file kwinrc --group TabBox --key LayoutName "thumbnail_grid"

# Require doubleclick to open folder in dolphin
kwriteconfig5 --file kdeglobals --group KDE --key SingleClick false

# Set default applications
kwriteconfig5 --file kdeglobals --group General --key BrowserApplication chromium.desktop
kwriteconfig5 --file kdeglobals --group General --key TerminalApplication foot
kwriteconfig5 --file kdeglobals --group General --key TerminalService org.codeberg.dnkl.foot.desktop

# Setup betterdiscord and install theme
betterdiscord-installer
curl https://raw.githubusercontent.com/catppuccin/discord/main/themes/mocha.theme.css | tee ~/.config/BetterDiscord/themes/mocha.theme.css
