source fn.sh || exit 1

remove_or_exit $(installdir)/xdg_base

git clone https://github.com/LazyVim/starter $(installdir)/xdg_base/.config/nvim --depth 1
rm -rf $(installdir)/xdg_base/.config/nvim/.git

# Colorscheme
remove_or_exit $(installdir)/xdg_base/.config/nvim/lua/colorscheme.lua
cp data/lazyvim/colorscheme.lua $(installdir)/xdg_base/.config/nvim/lua/plugins/

# Interactive installation of LazyVim plugins
source $(installdir)/.bashrc
nvim
