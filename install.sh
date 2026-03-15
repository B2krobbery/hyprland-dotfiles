#!/bin/bash

set -e

echo "Starting Hyprland setup..."

# Check if running on Arch Linux

if ! command -v pacman &> /dev/null; then
echo "This installer is intended for Arch Linux."
exit 1
fi

echo "Installing required packages..."

sudo pacman -S --needed hyprland waybar kitty rofi swappy

# Install AUR package if yay exists

if command -v yay &> /dev/null; then
echo "Installing wallust from AUR..."
yay -S --needed wallust
else
echo "yay not found. Skipping wallust installation."
fi

echo "Installing dotfiles..."

mkdir -p ~/.config
cp -r dotfiles/* ~/.config/

echo "Installation complete!"
echo "Restart Hyprland or reboot to apply changes."


