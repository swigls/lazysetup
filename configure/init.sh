source libsetup.sh || exit 1

mkdir -p "$(installdir)"

rc_append_line ~/.bashrc "source $(installdir)/.bashrc" && touch "$(installdir)/.bashrc"
rc_append_line ~/.inputrc '$include '"$(installdir)/.inputrc" && touch "$(installdir)/.inputrc"
rc_append_line ~/.vimrc "source $(installdir)/.vimrc" && touch "$(installdir)/.vimrc"
rc_append_line ~/.tmux.conf "source-file $(installdir)/.tmux.conf" && touch "$(installdir)/.tmux.conf"

# XDG base directories into $(installdir)
rc_append_line "$(installdir)/.bashrc" "export XDG_CONFIG_HOME=$(installdir)/xdg_base/.config"
rc_append_line "$(installdir)/.bashrc" "export XDG_DATA_HOME=$(installdir)/xdg_base/.local/share"
rc_append_line "$(installdir)/.bashrc" "export XDG_STATE_HOME=$(installdir)/xdg_base/.local/state"
rc_append_line "$(installdir)/.bashrc" "export XDG_CACHE_HOME=$(installdir)/xdg_base/.cache"
