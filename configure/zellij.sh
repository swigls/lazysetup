source libsetup.sh || exit 1

zellij_config_dir="$(lazysetup_root)/xdg_base/.config/zellij"
mkdir -p "$zellij_config_dir"
cp data/zellij/config.kdl "$zellij_config_dir"/config.kdl

mkdir -p "$zellij_config_dir/layouts"
cp data/zellij/layouts/default.kdl "$zellij_config_dir/layouts/default.kdl"

# Symlink ~/.config/zellij -> lazysetup-managed dir
# so zellij always uses the correct config regardless of XDG_CONFIG_HOME
default_config_dir="$HOME/.config/zellij"
if [ -L "$default_config_dir" ]; then
    rm "$default_config_dir"
elif [ -d "$default_config_dir" ]; then
    mv "$default_config_dir" "${default_config_dir}.bak"
fi
ln -s "$zellij_config_dir" "$default_config_dir"

# Install zellij-attention plugin (after symlink, so ~/.config/zellij/plugins/ resolves correctly)
mkdir -p "$HOME/.config/zellij/plugins"
curl -fL "https://github.com/KiryuuLight/zellij-attention/releases/latest/download/zellij-attention.wasm" \
    -o "$HOME/.config/zellij/plugins/zellij-attention.wasm"
