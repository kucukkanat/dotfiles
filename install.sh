git clone https://github.com/kucukkanat/dotfiles ~/dotfiles
cp -a ~/dotfiles/. ~/

# Install vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

