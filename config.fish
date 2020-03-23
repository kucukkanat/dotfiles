set PATH $HOME/bin $PATH
set PATH $HOME/go/bin $PATH
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $NPM_PACKAGES/bin $PATH
set MANPATH $NPM_PACKAGES/share/man $MANPATH  
set -x LSCOLORS gxfxcxdxbxegedabagacad

function gi
	curl -sL https://www.gitignore.io/api/$argv
end

function f
  fff $argv[1]
	cd (cat $HOME/.cache/fff/.fff_d)
end

function lg
	lazygit
end

