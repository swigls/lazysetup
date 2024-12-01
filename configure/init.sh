source fn.sh || exit 1

mkdir -p $(installdir)

rc_append_line ~/.bashrc 'source '$(installdir)'/.bashrc' && touch $(installdir)/.bashrc
rc_append_line ~/.inputrc '$include '$(installdir)'/.inputrc' && touch $(installdir)/.inputrc
rc_append_line ~/.vimrc 'source '$(installdir)'/.vimrc' && touch $(installdir)/.vimrc
rc_append_line ~/.tmux.conf 'source-file '$(installdir)'/.tmux.conf' && touch $(installdir)/.tmux.conf
