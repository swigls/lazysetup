source fn.sh || exit 1

if [[ $UNINSTALL ]]; then
  rm -rf $(installdir)
else
  mkdir -p $(installdir)
fi
rc_append_line ~/.bashrc 'source '$(installdir)'/.bashrc' && touch $(installdir)/.bashrc
rc_append_line ~/.inputrc '$include '$(installdir)'/.inputrc' && touch $(installdir)/.inputrc
rc_append_line ~/.vimrc 'source '$(installdir)'/.vimrc' && touch $(installdir)/.vimrc
rc_append_line ~/.tmux.conf 'source-file '$(installdir)'/.tmux.conf' && touch $(installdir)/.tmux.conf
