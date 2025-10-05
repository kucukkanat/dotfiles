#!/bin/bash

set -e

# Check if oh-my-bash is installed
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo "Installing oh-my-bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    echo "oh-my-bash installed"
else
    echo "oh-my-bash is already installed"
fi

# Check if basher is installed
if [ ! -d "$HOME/.basher" ]; then
    echo "Installing basher..."
    git clone --depth 1 https://github.com/basherpm/basher.git "$HOME/.basher"
    echo 'export PATH="$HOME/.basher/bin:$PATH"' >> "$HOME/.bash_profile"
    echo "basher installed"
else
    echo "basher is already installed"
fi

# Function to check and install packages
install_package() {
    local package=$1
    if ! command -v "$package" &> /dev/null; then
        echo "Installing $package..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            if command -v brew &> /dev/null; then
                brew install "$package"
            else
                echo "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Linux
            export DEBIAN_FRONTEND=noninteractive
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y "$package"
            elif command -v yum &> /dev/null; then
                sudo yum install -y "$package"
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm "$package"
            else
                echo "No known package manager found. Please install $package manually."
                exit 1
            fi
        fi
        echo "$package installed"
    else
        echo "$package is already installed"
    fi
}

# Install required tools
echo "Checking and installing required tools..."
install_package "tmux"
install_package "curl"
install_package "wget"
install_package "unzip"
install_package "vim"
install_package "git"
install_package "jq"

# Install fff using basher if available
if command -v basher &> /dev/null; then
    if [ ! -d "$HOME/.basher/packages/github.com/dylanaraps/fff" ]; then
        echo "Installing fff using basher..."
        basher install dylanaraps/fff
        echo "fff installed"
    else
        echo "fff is already installed via basher"
    fi
else
    echo "basher not found. fff will not be installed automatically."
fi

# Special handling for openssh-server (Linux only because macOS has it pre-installed)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! dpkg -l | grep -q openssh-server; then
        echo "Installing openssh-server..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y openssh-server
        elif command -v yum &> /dev/null; then
            sudo yum install -y openssh-server
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm openssh
        fi
        echo "openssh-server installed"
    else
        echo "openssh-server is already installed"
    fi
fi


# Copy dotfiles to home directory
echo "Installing dotfiles..."

# Copy .bash_profile
if [ -f ".bash_profile" ]; then
    cp ".bash_profile" "$HOME/.bash_profile"
    echo "Installed .bash_profile"
fi

# Copy .vimrc
if [ -f ".vimrc" ]; then
    cp ".vimrc" "$HOME/.vimrc"
    echo "Installed .vimrc"
fi

# Copy .tmux.conf
if [ -f ".tmux.conf" ]; then
    cp ".tmux.conf" "$HOME/.tmux.conf"
    echo "Installed .tmux.conf"
fi

# Source the new bash profile
echo "Sourcing .bash_profile..."
source "$HOME/.bash_profile"

echo "Dotfiles installation complete!"