#!/usr/bin/env bash

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Prompt

if [ -f ./bash_lib/git_prompt ] && [ -f ./bash_lib/git_completion ] ; then
    source ./bash_lib/git_prompt
    source ./bash_lib/git_completion
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
if [ -f ./bash_lib/bash_aliases ]; then
  source ./bash_lib/bash_aliases
fi

# Features

if [ -f ./bash_bin/fff ]; then
    # Run 'fff' with 'f' or whatever you decide to name the function.
    f() {
        fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
    }
fi
