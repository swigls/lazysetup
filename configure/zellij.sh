source libsetup.sh || exit 1

zellij_config_dir="$(lazysetup_root)/xdg_base/.config/zellij"
mkdir -p "$zellij_config_dir"
cp data/zellij/config.kdl "$zellij_config_dir"/config.kdl
