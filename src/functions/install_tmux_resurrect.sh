install_tmux_resurrect() {
  install_path="$HOME/tmux-plugins/tmux_resurrect"
  mkdir -p $install_path
  git clone https://github.com/tmux-plugins/tmux-resurrect $install_path
  # Add this to your .tmux.conf
  echo "run-shell $HOME/tmux-plugins/tmux_resurrect/resurrect.tmux" >> $HOME/.tmux.conf
}
