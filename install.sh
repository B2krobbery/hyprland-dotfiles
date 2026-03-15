#!/bin/bash

echo "Installing Hyprland environment..."

# Install required packages from official repo

sudo pacman -S --needed hyprland waybar kitty rofi swappy

echo "Installing Hyprland dotfiles..."

# Ensure config directory exists

mkdir -p ~/.config

# Copy all configs safely

cp -r dotfiles/* ~/.config/

echo "Dotfiles installed successfully!"
echo "Restart Hyprland or reboot to apply changes."


