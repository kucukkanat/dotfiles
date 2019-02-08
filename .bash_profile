#!/usr/bin/env bash

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Prompt

if [ -f ./lib/git_prompt ] && [ -f ./lib/git_completion ] ; then
    source ./lib/git_prompt
    source ./lib/git_completion
    PS1='\w:\e[32m$(__git_ps1 "[%s]")\e[0m $ '
else
    PS1='\w $ '
fi

# User binaries
if [ -d ~/bin ]; then
    # add your bin folder to the path, if you have it.
    # it's a good place to add all your scripts.
    export PATH=:~/bin:$PATH
fi

# generic settings and exports
if [ -f ~/.bashrc ] ; then
  source ~/.bashrc
fi

# aliases
if [ -f ./lib/bash_aliases ]; then
  source ./lib/bash_aliases
fi

# Features

if [ -f ./bin/fff ]; then
    # Run 'fff' with 'f' or whatever you decide to name the function.
    f() {
        fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
    }
fi