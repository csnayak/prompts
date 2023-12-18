#!/bin/bash

# Check for sudo privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script requires sudo privileges. Please run as root or with sudo."
    exit 1
fi

# Install curl if not installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    sudo apt-get update && sudo apt-get install -y curl
else
    echo "curl is already installed."
fi

# Install git if not installed
if ! command -v git &> /dev/null; then
    echo "git is not installed. Installing git..."
    sudo apt-get update && sudo apt-get install -y git
else
    echo "git is already installed."
fi

# Install Zsh
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing Zsh..."
    sudo apt-get update && sudo apt-get install -y zsh
else
    echo "Zsh is already installed."
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Install zsh-autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

# Install Starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Make Zsh default shell with Starship
echo "Setting Zsh as default shell..."
chsh -s $(which zsh)
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Create and populate the Starship TOML configuration file
echo "Configuring Starship..."
mkdir -p ~/.config && touch ~/.config/starship.toml
cat starship-config.toml  > ~/.config/starship.toml
#curl -fsSL https://raw.githubusercontent.com/theRubberDuckiee/dev-environment-files/main/starship.toml > ~/.config/starship.toml

echo "Installation and configuration complete!"
