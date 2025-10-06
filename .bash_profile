# ENV Variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=$PATH:$HOME/.bun/bin
export PATH=$PATH:$HOME/.deno/bin
export PATH=$PATH:$HOME/.bin


# Claude code configutaition
export DEEPSEEK_API_KEY="sk-xxxxxxxxxx"
export DEEPSEEK_BASE_URL="https://api.deepseek.com/anthropic"
export DEEPSEEK_MODEL="deepseek-chat"
export ZAI_BASE_URL="https://api.z.ai/api/anthropic"
export ZAI_MODEL="glm-4.5"
export ANTHROPIC_BASE_URL="${DEEPSEEK_BASE_URL}"
export ANTHROPIC_AUTH_TOKEN="${DEEPSEEK_API_KEY}"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="${DEEPSEEK_MODEL}"
export ANTHROPIC_DEFAULT_SONNET_MODEL="${DEEPSEEK_MODEL}"
export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.6"


# Warn if ANTHROPIC_AUTH_TOKEN is still the placeholder
if [[ -z "${ANTHROPIC_AUTH_TOKEN}" || "${ANTHROPIC_AUTH_TOKEN}" == "YOUR_API_KEY" ]]; then
    printf "\n\e[1;33m[WARNING] ANTHROPIC_AUTH_TOKEN is using the placeholder value.\e[0m\n"
    printf "Please update it with your API key:\n"
    printf "  \e[1;36mhttps://z.ai/manage-apikey/apikey-list\e[0m\n\n"
    printf "After updating, reload this file: \e[1;32msource ~/.bash_profile\e[0m\n\n"
fi

# Cross Platform Utility functions

# Starship prompt setter
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Basher package manager
export PATH="$HOME/.basher/bin:$PATH"
if command -v basher &> /dev/null; then
    eval "$(basher init - bash)"
fi

# Check deepseek remaining balance
deepseek_chk(){
curl -s -H "Authorization: Bearer ${DEEPSEEK_API_KEY}" https://api.deepseek.com/user/balance | jq -r '"\uf2dc DeepSeek Balance: \(.balance) 🔑"'
}
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
fi

# Aliases
# alias claude="bunx @anthropic-ai/claude-code"
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
