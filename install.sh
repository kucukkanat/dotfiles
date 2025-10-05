#!/bin/bash
source ./utils.sh
set -e

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
    source "$HOME/.bash_profile"
else
    echo "basher is already installed"
fi


# Install required tools
echo "Checking and installing required tools..."
ensure_installed "tmux"
ensure_installed "curl"
ensure_installed "wget"
ensure_installed "unzip"
ensure_installed "vim"
ensure_installed "git"
ensure_installed "jq"
ensure_installed "fzf"

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
    ensure_installed "openssh-server"
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

# Copy utils
if [ -f "utils.sh" ]; then
    cp "utils.sh" "$HOME/utils.sh"
    echo "Installed utils.sh"
fi

# Source the new bash profile
echo "Re-Sourcing .bash_profile..."
source "$HOME/.bash_profile"

echo "Dotfiles installation complete!"