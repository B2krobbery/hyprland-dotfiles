#!/bin/bash
set -e

echo "Starting Hyprland setup..."

# Ensure we're on Arch (pacman exists)

if ! command -v pacman >/dev/null 2>&1; then
echo "This installer supports Arch Linux only."
exit 1
fi

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing required packages..."

PACKAGES=(
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
zsh
thunar
thunar-archive-plugin
file-roller
fastfetch
git
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

echo "Installing Zsh plugins..."
mkdir -p ~/.zsh

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
fi

echo "Creating directories..."
mkdir -p ~/.config
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/Wallpapers

echo "Copying dotfiles..."
cp -r dotfiles/* ~/.config/

if [ -f dotfiles/.zshrc ]; then
cp dotfiles/.zshrc ~/
fi

echo "Setting Zsh as default shell..."
chsh -s /bin/zsh

echo "Installation complete!"
echo "Restart Hyprland or reboot."
