source fn.sh || exit 1

remove_or_exit $(installdir)/xdg_base/.config/nvim
remove_or_exit $(installdir)/xdg_base/.local/share/nvim
remove_or_exit $(installdir)/xdg_base/.local/state/nvim
remove_or_exit $(installdir)/xdg_base/.cache/nvim

git clone https://github.com/LazyVim/starter $(installdir)/xdg_base/.config/nvim --depth 1
rm -rf $(installdir)/xdg_base/.config/nvim/.git

# Plugins
for filepath in data/lazyvim/plugins/*; do
  filename=$(basename $filepath)
  cp -f $filepath $(installdir)/xdg_base/.config/nvim/lua/plugins/
done

# Configs
for filepath in data/lazyvim/config/*; do
  filename=$(basename $filepath)
  cp -f $filepath $(installdir)/xdg_base/.config/nvim/lua/config/
done

# Interactive installation of LazyVim plugins
source $(installdir)/.bashrc
nvim
