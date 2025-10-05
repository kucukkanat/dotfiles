#!/usr/bin/env bash

# Make sure this is an idempotent script
rm -rf ~/.vim

# Create necessary Vim directories
# See https://gist.github.com/manasthakur/ab4cf8d32a28ea38271ac0d07373bb53 and https://linuxconfig.org/how-to-manage-vim-plugins-natively
mkdir -p ~/.vim/pack/{colorschemes,syntax,others}/{start,opt}

clone_plugin() {
    local repo=$1
    local name=$2
    echo "Installing $name..."
    if [ ! -d ~/.vim/pack/plugins/start/$name ]; then
        git clone --depth 1 https://github.com/$repo ~/.vim/pack/plugins/start/$name
    else
        echo "$name already installed"
    fi
}


# Install essential plugins using Vim's native package system
echo "Installing plugins..."

# Color scheme
clone_plugin "morhetz/gruvbox" "gruvbox"

# File explorer (netrw is built-in, but let's add a better one)
clone_plugin "preservim/nerdtree" "nerdtree"

# Status line
clone_plugin "vim-airline/vim-airline" "vim-airline"
clone_plugin "vim-airline/vim-airline-themes" "vim-airline-themes"

# Fuzzy finder (requires fzf binary and base plugin)
clone_plugin "junegunn/fzf" "fzf"
clone_plugin "junegunn/fzf.vim" "fzf.vim"

    


# Syntax highlighting
clone_plugin "sheerun/vim-polyglot" "vim-polyglot"

# Git integration
clone_plugin "tpope/vim-fugitive" "vim-fugitive"
clone_plugin "airblade/vim-gitgutter" "vim-gitgutter"

# Auto pairs
clone_plugin "jiangmiao/auto-pairs" "auto-pairs"

# Comments
clone_plugin "tpope/vim-commentary" "vim-commentary"

# Surround
clone_plugin "tpope/vim-surround" "vim-surround"

# Indent guides
clone_plugin "Yggdroot/indentLine" "indentLine"

# Terminal (built-in terminal is available in Vim 8.1+, but floaterm provides better UX)
clone_plugin "voldikss/vim-floaterm" "vim-floaterm"

echo ""
echo "=== Vim Plugin Usage Tips ==="
echo ""
echo "🎨 Gruvbox (Color Scheme):"
echo "   :colorscheme gruvbox     - Apply gruvbox theme"
echo "   :set background=dark     - Dark background (default)"
echo "   :set background=light    - Light background"
echo ""
echo "📁 NERDTree (File Explorer):"
echo "   :NERDTree                - Toggle NERDTree"
echo "   :NERDTreeToggle          - Toggle NERDTree"
echo "   :NERDTreeFind            - Find current file in NERDTree"
echo "   Ctrl+ww                  - Switch between NERDTree and editor"
echo "   m (in NERDTree)          - Show menu (add, delete, rename files)"
echo ""
echo "📊 Vim-Airline (Status Line):"
echo "   :AirlineTheme <theme>    - Change airline theme"
echo "   :AirlineTheme list        - List available themes"
echo "   Shows git branch, file type, and more in status bar"
echo ""
echo "🔍 FZF (Fuzzy Finder):"
echo "   :Files                   - Fuzzy find files"
echo "   :GFiles                  - Fuzzy find git files"
echo "   :Buffers                 - Fuzzy find open buffers"
echo "   :Lines                   - Fuzzy find lines in buffer"
echo "   :BLines                  - Fuzzy find lines in all buffers"
echo "   :Ag <pattern>            - Search using ag (if installed)"
echo ""
echo "🌐 Vim-Polyglot (Syntax):"
echo "   Provides syntax highlighting for hundreds of languages"
echo "   No special commands needed - works automatically"
echo ""
echo "🔧 Vim-Fugitive (Git):"
echo "   :Gstatus                 - Show git status"
echo "   :Gdiff                   - Show git diff"
echo "   :Gcommit                 - Git commit"
echo "   :Gpush                   - Git push"
echo "   :Gpull                   - Git pull"
echo "   :Gblame                  - Show git blame"
echo ""
echo "📈 Vim-GitGutter (Git Diff):"
echo "   Shows git diff signs in the gutter (+ - ~)"
echo "   ]c                       - Jump to next hunk"
echo "   [c                       - Jump to previous hunk"
echo "   <Leader>hp               - Preview hunk"
echo "   <Leader>hs               - Stage hunk"
echo "   <Leader>hu               - Undo hunk"
echo ""
echo "👥 Auto-Pairs:"
echo "   Automatically pairs brackets, quotes, etc."
echo "   Works automatically - no commands needed"
echo ""
echo "💬 Vim-Commentary:"
echo "   gcc                      - Comment/uncomment line"
echo "   gc                       - Comment/uncomment selection (visual mode)"
echo "   gc5j                     - Comment 5 lines down"
echo ""
echo "🔲 Vim-Surround:"
echo "   ys\"w                    - Surround word with quotes"
echo "   cs\"'                    - Change surrounding quotes to single quotes"
echo "   ds\"                     - Delete surrounding quotes"
echo "   yst)                    - Surround tag with parentheses"
echo ""
echo "📏 IndentLine:"
echo "   Shows vertical indent lines"
echo "   :IndentLinesToggle       - Toggle indent lines"
echo "   :IndentLinesReset       - Reset indent lines"
echo ""
echo "💻 Floaterm (Terminal):"
echo "   :FloatermNew             - Open new terminal"
echo "   :FloatermToggle          - Toggle terminal"
echo "   :FloatermNext            - Next terminal"
echo "   :FloatermPrev            - Previous terminal"
echo "   :FloatermKill            - Kill terminal"
echo "   Ctrl+\                   - Toggle floaterm (default mapping)"
echo ""
echo "=== General Tips ==="
echo "• Use :help <plugin-name> for detailed documentation"
echo "• Most plugins work with visual selections too"
echo "• Leader key is typically \\ (backslash) by default"
echo "• Press Tab in command mode to autocomplete commands"
echo ""


