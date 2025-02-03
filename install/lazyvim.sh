source libsetup.sh || exit 1

remove_or_exit $(lazysetup_root)/xdg_base/.config/nvim
remove_or_exit $(lazysetup_root)/xdg_base/.local/share/nvim
remove_or_exit $(lazysetup_root)/xdg_base/.local/state/nvim
remove_or_exit $(lazysetup_root)/xdg_base/.cache/nvim

git clone https://github.com/LazyVim/starter $(lazysetup_root)/xdg_base/.config/nvim --depth 1
rm -rf $(lazysetup_root)/xdg_base/.config/nvim/.git

