#!/bin/bash

set -e

echo "Starting Hyprland setup..."

# Check if Arch Linux

if ! command -v pacman &> /dev/null; then
echo "This installer is only for Arch Linux."
exit 1
fi

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing required packages..."

sudo pacman -S --needed --noconfirm 
hyprland 
waybar 
kitty 
rofi 
swappy 
swww 
grim 
slurp 
wl-clipboard 
xdg-desktop-portal-hyprland 
xdg-user-dirs 
ttf-font-awesome 
ttf-dejavu 
ttf-liberation 
noto-fonts 
network-manager-applet 
blueman

# Install wallust if yay exists

if command -v yay &> /dev/null; then
echo "Installing wallust from AUR..."
yay -S --needed --noconfirm wallust
else
echo "yay not installed, skipping wallust"
fi

echo "Installing dotfiles..."

mkdir -p ~/.config
cp -r dotfiles/* ~/.config/

echo "Setup complete!"
echo "Reboot or run: start-hyprland"


