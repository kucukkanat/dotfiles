# CROSS PLATFORM UTILITY FUNCTIONS FOR BASH

# Function to install a package if not already installed
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

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."   
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_deno() {
    if ! command -v deno &> /dev/null; then
        echo "Installing Deno..."
        curl -fsSL https://deno.land/install.sh | sh -s -- -y
        export PATH="$HOME/.deno/bin:$PATH"
    fi
}

install_bun() {
    if ! command -v bun &> /dev/null; then
        echo "Installing Bun..."
        curl -fsSL https://bun.sh/install | bash
        export PATH="$HOME/.bun/bin:$PATH"
    fi
}