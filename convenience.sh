#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"
### Convenience script to install dotfiles

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
