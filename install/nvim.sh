source fn.sh || exit 1

remove_or_exit $(installdir)/nvim

curl_tar_and_extract https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
mv nvim-linux64 $(installdir)/nvim

rc_append_line $(installdir)/.bashrc 'export PATH='$(installdir)'/nvim/bin:$PATH'

# XDG base directories into $(installdir)
rc_append_line $(installdir)/.bashrc "export XDG_CONFIG_HOME=$(installdir)/xdg_base/.config"
rc_append_line $(installdir)/.bashrc "export XDG_DATA_HOME=$(installdir)/xdg_base/.local/share"
rc_append_line $(installdir)/.bashrc "export XDG_STATE_HOME=$(installdir)/xdg_base/.local/state"
rc_append_line $(installdir)/.bashrc "export XDG_CACHE_HOME=$(installdir)/xdg_base/.cache"
