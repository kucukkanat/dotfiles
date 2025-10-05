#!/usr/bin/env bash
### Convenience script to install dotfiles


# Check if sudo is installed (Linux only)
if [[ "$OSTYPE" == "linux-gnu"* ]] && ! command -v sudo &> /dev/null; then
    echo "Installing sudo..."
    if command -v apt-get &> /dev/null; then
        su -c "apt-get update && apt-get install -y sudo"
    elif command -v yum &> /dev/null; then
        su -c "yum install -y sudo"
    elif command -v pacman &> /dev/null; then
        su -c "pacman -S --noconfirm sudo"
    else
        echo "No known package manager found. Please install sudo manually."
        exit 1
    fi
    echo "sudo installed"
fi

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


echo "=== Cleanup ==="
read -p "Do you want to delete the temporary directory created during installation? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleaning up temporary files..."
    cd ..
    rm -rf "$TEMP_DIR"
    echo "Installation complete and temporary directory cleaned up"
    # Note: This script doesn't create temp directories, but if it did, they would be cleaned here
    echo "Cleanup complete."
else
    echo "Temporary files preserved."
fi