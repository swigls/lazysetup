source libsetup.sh || exit 1

mkdir -p "$(lazysetup_root)"/bin

rc_append_line ~/.bashrc "source $(lazysetup_root)/.bashrc" && touch "$(lazysetup_root)/.bashrc"
rc_append_line ~/.inputrc '$include '"$(lazysetup_root)/.inputrc" && touch "$(lazysetup_root)/.inputrc"
rc_append_line ~/.vimrc "source $(lazysetup_root)/.vimrc" && touch "$(lazysetup_root)/.vimrc"
rc_append_line ~/.tmux.conf "source-file $(lazysetup_root)/.tmux.conf" && touch "$(lazysetup_root)/.tmux.conf"

# XDG base directories into $(lazysetup_root)
rc_append_line "$(lazysetup_root)/.bashrc" "export XDG_CONFIG_HOME=$(lazysetup_root)/xdg_base/.config"
rc_append_line "$(lazysetup_root)/.bashrc" "export XDG_DATA_HOME=$(lazysetup_root)/xdg_base/.local/share"
rc_append_line "$(lazysetup_root)/.bashrc" "export XDG_STATE_HOME=$(lazysetup_root)/xdg_base/.local/state"
rc_append_line "$(lazysetup_root)/.bashrc" "export XDG_CACHE_HOME=$(lazysetup_root)/xdg_base/.cache"
