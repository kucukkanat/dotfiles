#!/usr/bin/env bash

# .bash_profile
# ----------------------------

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

# exports
if [ -f ~/.bash_exports ]; then
  source ~/.bash_exports
fi

# aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# Prompt
if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
fi

# Features

if [ -f ~/bin/fff ]; then
    # Run 'fff' with 'f' or whatever you decide to name the function.
    f() {
        fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
    }
fi