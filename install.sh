#!/bin/bash

set -e

echo "Starting Hyprland setup..."

# Check if pacman exists
if ! command -v pacman &> /dev/null; then
    echo "This installer only supports Arch Linux."
    exit 1
fi

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing required packages..."

sudo pacman -S --needed --noconfirm \
hyprland \
waybar \
kitty \
rofi \
swappy \
swww \
grim \
slurp \
wl-clipboard \
xdg-desktop-portal-hyprland \
xdg-user-dirs \
ttf-font-awesome \
ttf-dejavu \
ttf-liberation \
noto-fonts \
network-manager-applet \
blueman \
zsh \
thunar \
thunar-archive-plugin \
file-roller \
fastfetch \
git \
base-devel

echo "Installing yay (AUR helper)..."

if ! command -v yay &> /dev/null; then
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
fi

echo "Installing wallust from AUR..."

yay -S --noconfirm wallust

echo "Installing Oh My Zsh..."

if [ ! -d ~/.oh-my-zsh ]; then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

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
echo "Restart your system or start Hyprland."
