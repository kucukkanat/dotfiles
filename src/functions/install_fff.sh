install_fff() {
    mkdir -p $HOME/bin
    curl https://raw.githubusercontent.com/dylanaraps/fff/master/fff >$HOME/bin/fff
    chmod +x $HOME/bin/fff
}

install_fff
