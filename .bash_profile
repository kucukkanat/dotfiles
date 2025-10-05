# ENV Variables
export LC_ALL=C
export LANG=C

export PATH=$PATH:$HOME/.bun/bin
export PATH=$PATH:$HOME/.deno/bin

# Starship prompt setter
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Basher package manager
export PATH="$HOME/.basher/bin:$PATH"
if command -v basher &> /dev/null; then
    eval "$(basher init - bash)"
fi


# Kill all docker containers
dka() {
    docker rm $(docker ps -aq) -f
}

# Edit bash profile conveniently
editprofile() {
    local bp="$HOME/.bash_profile"
    vim $bp  && source $bp
}

# fff file manager
if command -v fff &> /dev/null; then
    export FFF_OPTS="--color=auto --show-hidden --show-details --preview"
    f() {
        fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
    }
else
    echo "fff is not installed. You can install it using basher: basher install dylanaraps/fff"
fi

# Aliases
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m"
alias gp="git push origin HEAD"
alias gl="git log --oneline --graph --decorate --all"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias psg="ps aux | grep"
alias v="vim"
alias x="exit"
alias mkdir="mkdir -pv"
alias cdd="cd ~/Developer"