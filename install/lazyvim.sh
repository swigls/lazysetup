source fn.sh || exit 1

remove_or_exit $(installdir)/xdg_base/.config/nvim
remove_or_exit $(installdir)/xdg_base/.local/share/nvim
remove_or_exit $(installdir)/xdg_base/.local/state/nvim
remove_or_exit $(installdir)/xdg_base/.cache/nvim

git clone https://github.com/LazyVim/starter $(installdir)/xdg_base/.config/nvim --depth 1
rm -rf $(installdir)/xdg_base/.config/nvim/.git

