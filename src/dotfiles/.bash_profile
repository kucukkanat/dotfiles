export LC_ALL=en_US.UTF-8
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.npm-packages/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export BASH_SILENCE_DEPRECATION_WARNING=1
export LSCOLORS=gxfxcxdxbxegedabagacad
# To avoid git commit signing error
export GPG_TTY=$(tty)

tp(){
  cd $(dirname $(fzf));
}
# For gokcehan/lf : https://github.com/gokcehan/lf/
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# FFF https://github.com/dylanaraps/fff
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

lg() {
    lazygit
}
fif() {
  grep --line-buffered --color=never -r "" * | fzf
}
function gi() { curl -sL https://www.gitignore.io/api/\$@ ;}
# Git Prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
# Git completion
source $HOME/git-completion

