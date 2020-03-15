export PATH="$PATH:/root/go/bin"
export PATH="$PATH:$HOME/bin"
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

fif() {
  grep --line-buffered --color=never -r "" * | fzf
}
# Git Prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

source $HOME/git-completion

