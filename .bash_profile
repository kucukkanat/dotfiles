# ENV Variables
export LC_ALL=C
export LANG=C

export PATH=$PATH:$HOME/.bun/bin
export PATH=$PATH:$HOME/.deno/bin

# Claude code configutaition
export ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic
export ANTHROPIC_AUTH_TOKEN="YOUR_API_KEY"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.6"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.6"
# Warn if ANTHROPIC_AUTH_TOKEN is still the placeholder
if [[ -z "${ANTHROPIC_AUTH_TOKEN}" || "${ANTHROPIC_AUTH_TOKEN}" == "YOUR_API_KEY" ]]; then
    printf "\n\e[1;33m[WARNING] ANTHROPIC_AUTH_TOKEN is using the placeholder value.\e[0m\n"
    printf "Please update it with your API key:\n"
    printf "  \e[1;36mhttps://z.ai/manage-apikey/apikey-list\e[0m\n\n"
    printf "After updating, reload this file: \e[1;32msource ~/.bash_profile\e[0m\n\n"
fi

# Cross Platform Utility functions
source "$HOME/utils.sh"

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
    echo "Bash profile edited and reloaded!"
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
