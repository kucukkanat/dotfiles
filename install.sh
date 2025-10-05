#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
ensure_installed(){
    local pkg=$1
    local use_sudo=false
    
    # Parse arguments: shift to remove the first argument (package name)
    # then loop through remaining arguments to find flags
    shift
    while [[ $# -gt 0 ]]; do
        case $1 in
            --sudo)
                # Set use_sudo to true when --sudo flag is found
                use_sudo=true
                shift
                # Terminator for the case statement
                ;;
            *)
                # Skip any unknown arguments
                shift
                ;;
        esac
    done
    
    if ! command -v $pkg &> /dev/null; then
        echo "Installing $pkg..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt-get &> /dev/null; then
                if [ "$use_sudo" = "true" ]; then
                    sudo apt-get update && sudo apt-get install -y $pkg
                else
                    apt-get update && apt-get install -y $pkg
                fi
            elif command -v yum &> /dev/null; then
                if [ "$use_sudo" = "true" ]; then
                    sudo yum install -y $pkg
                else
                    yum install -y $pkg
                fi
            elif command -v pacman &> /dev/null; then
                if [ "$use_sudo" = "true" ]; then
                    sudo pacman -S --noconfirm $pkg
                else
                    pacman -S --noconfirm $pkg
                fi
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
ensure_installed "tmux" --sudo
ensure_installed "curl" --sudo
ensure_installed "wget" --sudo
ensure_installed "unzip" --sudo
ensure_installed "vim" --sudo
ensure_installed "git" --sudo
ensure_installed "jq" --sudo
ensure_installed "fzf" --sudo

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

# Install Starship for cool terminal prompt
if ! command -v starship &> /dev/null; then
    echo "Installing Starship prompt..."
    curl -fsSL https://starship.rs/install.sh | sh
fi

# Special handling for openssh-server (Linux only because macOS has it pre-installed)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ensure_installed "openssh-server" --sudo
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

# Copy .config directory
if [ -d ".config" ]; then
    cp -r ".config" "$HOME/.config"
    echo "Installed .config directory"
fi

# Copy .continue directory
if [ -d ".continue" ]; then
    cp -r ".continue" "$HOME/.continue"
    echo "Installed .continue directory"
fi

# Source the new bash profile
echo "Re-Sourcing .bash_profile..."
source "$HOME/.bash_profile"

echo "Dotfiles installation complete!"