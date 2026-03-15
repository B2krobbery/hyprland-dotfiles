#!/bin/bash

echo "Installing Hyprland environment..."

# Install required packages

sudo pacman -S --needed hyprland waybar kitty rofi swappy wallust

echo "Installing Hyprland dotfiles..."

# Ensure config directory exists

mkdir -p ~/.config

# Ensure GTK config directory exists

mkdir -p ~/.config/gtk-3.0

# Copy configs

cp -r dotfiles/hypr ~/.config/
cp -r dotfiles/waybar ~/.config/
cp -r dotfiles/kitty ~/.config/
cp -r dotfiles/rofi ~/.config/
cp -r dotfiles/swappy ~/.config/
cp -r dotfiles/wallust ~/.config/
cp -r dotfiles/gtk-3.0 ~/.config/

echo "Dotfiles installed successfully!"
echo "Restart Hyprland or reboot to apply changes."

