source libsetup.sh || exit 1

helix_config_dir="$(lazysetup_root)/xdg_base/.config/helix"
mkdir -p "$helix_config_dir"
cp data/helix/config.toml "$helix_config_dir/config.toml"

# Symlink ~/.config/helix -> lazysetup-managed dir
default_config_dir="$HOME/.config/helix"
if [ -L "$default_config_dir" ]; then
    rm "$default_config_dir"
elif [ -d "$default_config_dir" ]; then
    mv "$default_config_dir" "${default_config_dir}.bak"
fi
ln -s "$helix_config_dir" "$default_config_dir"
