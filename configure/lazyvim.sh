source fn.sh || exit 1

# Plugins
for filepath in data/lazyvim/plugins/*; do
  filename=$(basename "$filepath")
  cp -f "$filepath" "$(installdir)"/xdg_base/.config/nvim/lua/plugins/
done

# Configs
for filepath in data/lazyvim/config/*; do
  filename=$(basename "$filepath")
  cp -f "$filepath" "$(installdir)"/xdg_base/.config/nvim/lua/config/
done

# Interactive Installation
source ~/.bashrc
nvim

