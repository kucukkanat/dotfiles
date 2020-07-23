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


function lfcd
    set tmp (mktemp)
    lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

# Git shortcuts
abbr -a -g gpush git push origin HEAD
abbr -a -g gc git commit -m
abbr -a -g ga git add .
abbr -a -g gpull git pull origin (git rev-parse --abbrev-ref HEAD)
