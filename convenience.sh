#!/usr/bin/env bash
### Convenience script to install dotfiles

# Check if git is installed (Linux only)
if [[ "$OSTYPE" == "linux-gnu"* ]] && ! command -v git &> /dev/null; then
    echo "Installing git..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y git
    elif command -v yum &> /dev/null; then
        sudo yum install -y git
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm git
    else
        echo "No known package manager found. Please install git manually."
        exit 1
    fi
    echo "git installed"
fi

# Create temporary directory for installation
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Clone dotfiles to temp directory
git clone https://github.com/kucukkanat/dotfiles --depth=1 "$TEMP_DIR"

# Run install script from temp directory
cd "$TEMP_DIR"
bash install.sh
bash configure-vim.sh

# Clean up
cd ..
rm -rf "$TEMP_DIR"
echo "Installation complete and temporary directory cleaned up"