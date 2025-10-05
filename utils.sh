# CROSS PLATFORM UTILITY FUNCTIONS FOR BASH

export NONINTERACTIVE=1
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