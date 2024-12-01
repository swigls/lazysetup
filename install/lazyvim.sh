source fn.sh || exit 1

remove_or_exit $(installdir)/.config/nvim
remove_or_exit $(installdir)/.local/share/nvim
remove_or_exit $(installdir)/.local/state/nvim
remove_or_exit $(installdir)/.cache/nvim

git clone https://github.com/LazyVim/starter $(installdir)/.config/nvim --depth 1
rm -rf $(installdir)/.config/nvim/.git

# Colorscheme
remove_or_exit $(installdir)/.config/nvim/lua/colorscheme.lua
cp data/lazyvim/colorscheme.lua $(installdir)/.config/nvim/lua/plugins/

# Interactive installation of LazyVim plugins
source $(installdir)/.bashrc
nvim
