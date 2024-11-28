source fn.sh || exit 1

remove_or_exit ~/.config/nvim
remove_or_exit ~/.local/share/nvim
remove_or_exit ~/.local/state/nvim
remove_or_exit ~/.cache/nvim

git clone https://github.com/LazyVim/starter ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/.git

source ~/.bashrc
nvim
