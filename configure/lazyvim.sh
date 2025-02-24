source libsetup.sh || exit 1

# Remove previous setting
rm -rf "$(lazysetup_root)"/xdg_base/.config/nvim
# rm -rf $(lazysetup_root)/xdg_base/.local/share/nvim
# rm -rf $(lazysetup_root)/xdg_base/.local/state/nvim
# rm -rf $(lazysetup_root)/xdg_base/.cache/nvim

# Up-to-date lazyvim config
git clone https://github.com/LazyVim/starter "$(lazysetup_root)"/xdg_base/.config/nvim --depth 1
rm -rf "$(lazysetup_root)"/xdg_base/.config/nvim/.git

# Plugins
for filepath in data/lazyvim/plugins/*; do
  filename=$(basename "$filepath")
  cp -f "$filepath" "$(lazysetup_root)"/xdg_base/.config/nvim/lua/plugins/
done

# Configs
for filepath in data/lazyvim/config/*; do
  filename=$(basename "$filepath")
  cp -f "$filepath" "$(lazysetup_root)"/xdg_base/.config/nvim/lua/config/
done
