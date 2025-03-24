#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install zsh
echo "Installing zsh..."
sudo apt install -y zsh
chsh -s $(which zsh)
sudo apt install -y lsd unzip

# Initialize INSTALL_OH_MY_ZSH
INSTALL_OH_MY_ZSH=""

# Check for the -y flag
while getopts "y" opt; do
    case $opt in
        y)
            INSTALL_OH_MY_ZSH="y"
            ;;
        *)
            echo "Usage: $0 [-y]"
            exit 1
            ;;
    esac
done

# If -y is used, automatically set INSTALL_OH_MY_ZSH to "y"
if [[ "$INSTALL_OH_MY_ZSH" == "y" ]]; then
    echo "Automatically installing Oh My Zsh..."
else
    # Prompt for Oh My Zsh installation
    read -p "Would you like to install Oh My Zsh? [Y or N]: " INSTALL_OH_MY_ZSH
fi

if [[ "$INSTALL_OH_MY_ZSH" =~ ^[Yy]$ ]]; then
    # Install Oh My Zsh
    echo "Installing Oh My Zsh..."
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Move .zshrc to home directory
    mv ~/.zshrc ~/.zshrc.bak
    cp .zshrc ~

    # Add Oh My Zsh plugins
    echo "Adding Oh My Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Verify installation
    if [ -d "$HOME/.oh-my-zsh" ]; then
       echo "Oh My Zsh installed successfully."
    else
       echo "Oh My Zsh installation failed."
    fi
else
    echo "Skipping Oh My Zsh installation."
fi

# Verify installation
echo "Verifying installations..."
if command -v zsh &> /dev/null; then 
    echo "zsh installed successfully: $(zsh --version)"
else
    echo "zsh installation failed."
fi

echo "Zsh installation script completed"
