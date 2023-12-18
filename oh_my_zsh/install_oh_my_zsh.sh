#!/bin/bash

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

# Install Powerline Fonts
echo "Installing Powerline fonts..."
sudo apt-get install -y fonts-powerline

# Clone the Powerlevel10k theme repository into Oh My Zsh's themes directory
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Set Powerlevel10k as the default theme in .zshrc
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Remove the username and hostname from the prompt
sed -i '/^PROMPT=/c\PROMPT="%{$fg[green]%}%1~ %{${reset_color}%}$(git_prompt_info)"' ~/.zshrc

echo "Powerlevel10k theme installed. You can now run 'p10k configure' to configure the Powerlevel10k theme."

echo "Customizing the terminal prompt colors..."
cat << 'EOF' >> ~/.zshrc

# Custom prompt colors
autoload -U colors && colors
setopt prompt_subst
PROMPT='%{$fg[green]%}%1~ %{${reset_color}%}$(git_prompt_info)'

# Customizing the Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
EOF

echo "Installation and configuration complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
