source fn.sh || exit 1

maybe_remove ~/.config/nvim
maybe_remove ~/.local/share/nvim
maybe_remove ~/.local/state/nvim
maybe_remove ~/.cache/nvim

git clone https://github.com/LazyVim/starter ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/.git

source ~/.bashrc
nvim

configure/lazyvim.sh
