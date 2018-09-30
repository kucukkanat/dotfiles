# GIT Autocompletion
# https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks

alias ls='ls -G'
alias tree1="tree -L 1"
alias tree2="tree -L 2 -I 'node_modules' "

# Git branch name
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
promptfn(){
    export PS1=" \w$c_GREEN : $(git branch 2>/dev/null | grep '^*' | colrm 1 2) ${c_RESTORE} 🌵  "
}
export PROMPT_COMMAND="promptfn"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"