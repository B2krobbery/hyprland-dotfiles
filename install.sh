#!/bin/bash

echo "Installing Hyprland dotfiles..."

mkdir -p ~/.config

cp -r dotfiles/hypr ~/.config/
cp -r dotfiles/waybar ~/.config/
cp -r dotfiles/rofi ~/.config/
cp -r dotfiles/kitty ~/.config/
cp -r dotfiles/wallust ~/.config/
cp -r dotfiles/swappy ~/.config/
cp -r dotfiles/gtk-3.0 ~/.config/

echo "Done! Restart Hyprland or Waybar to apply changes."
