#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install zsh
echo "Installing zsh..."
sudo apt install -y zsh
chsh -s $(which zsh)

# Install ohmyzsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Move .zshrc to home directory
mv ~/.zshrc ~/.zshrc.bak
cp .zshrc ~

# Add ohmyzsh plugins
echo "Adding Oh My Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install tmux
echo "Installing tmux..."
sudo apt install -y tmux

# Install tmux package manager
echo "Installing tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/tpm

# Move .tmux.conf to home directory
mv ~/.tmux.conf ~/.tmux.conf.bak
cp .tmux.conf ~

# Source tmux configuration
tmux source-file ~/.tmux.conf

# Verify installations
echo "Verifying installations..."
if command -v zsh &> /dev/null; then 
	echo "zsh installed successfully: $(zsh --version)"
else
	echo "zsh installation failed."
fi

if command -v tmux &> /dev/null; then 
	echo "tmux installed successfully: $(tmux -V)"
else
	echo "tmux installation failed."
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh installed successfully."
else
    echo "Oh My Zsh installation failed."
fi

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TPM installed successfully."
else
    echo "TPM installation failed."
fi

echo "Installation script completed, run <leader>+I in tmux to install plugins"

# Start a new Zsh session
exec zsh
