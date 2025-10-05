#!/usr/bin/env bash
### Convenience script to install dotfiles


export DEBIAN_FRONTEND=noninteractive
ensure_installed(){
    local pkg=$1
    if ! command -v $pkg &> /dev/null; then
        echo "Installing $pkg..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y $pkg
            elif command -v yum &> /dev/null; then
                sudo yum install -y $pkg
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm $pkg
            else
                echo "No known package manager found. Please install $pkg manually."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            if command -v brew &> /dev/null; then
                brew install $pkg
            else
                echo "Homebrew not found. Please install Homebrew and rerun the script."
                exit 1
            fi
        else
            echo "Unsupported OS. Please install $pkg manually."
            exit 1
        fi
        echo "$pkg installed"
    else
        echo "$pkg is already installed"
    fi
    echo ""
}
# Check if sudo is installed (Linux only)
ensure_installed "sudo"

# Check if git is installed (Linux only)
ensure_installed "git"

# Create temporary directory for installation
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Clone dotfiles to temp directory
git clone https://github.com/kucukkanat/dotfiles --depth=1 "$TEMP_DIR"

# Run install script from temp directory
cd "$TEMP_DIR"
bash install.sh
bash install-vim-plugins.sh
