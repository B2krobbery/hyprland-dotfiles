#!/bin/bash

set -e

# Prevent running as root

if [ "$EUID" -eq 0 ]; then
echo "Do NOT run this script with sudo."
echo "Run it as a normal user:"
echo "./install.sh"
exit 1
fi

# Fix ownership if repo was cloned with sudo

if [ -d "$HOME/hyprland-dotfiles" ]; then
sudo chown -R "$USER:$USER" "$HOME/hyprland-dotfiles"
fi

echo "Starting Hyprland setup..."

# Check if pacman exists

if ! command -v pacman &> /dev/null; then
echo "This installer only supports Arch Linux."
exit 1
fi

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing required packages..."

packages=(
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
base-devel
)

sudo pacman -S --needed --noconfirm "${packages[@]}"

echo "Installing yay (AUR helper)..."

if ! command -v yay &> /dev/null; then
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
fi

echo "Installing wallust..."
yay -S --noconfirm wallust-bin

echo "Installing Oh My Zsh..."

if [ ! -d ~/.oh-my-zsh ]; then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Installing Zsh plugins..."

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Ensure directories exist

mkdir -p "$ZSH_CUSTOM/plugins"
mkdir -p "$ZSH_CUSTOM/themes"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "Installing Powerlevel10k theme..."

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
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
echo "Reboot or start Hyprland."
