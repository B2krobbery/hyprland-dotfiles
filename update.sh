#!/bin/bash

echo "Updating dotfiles backup..."

cd ~/hyprland-dotfiles || exit

git add .

git commit -m "Auto update $(date)"

git push

echo "Dotfiles synced to GitHub."
