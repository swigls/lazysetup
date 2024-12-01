source fn.sh || exit 1

remove_or_exit $(installdir)/bin

mkdir -p $(installdir)/bin
cp bin/* $(installdir)/bin/
rc_append_line $(installdir)/.bashrc 'export PATH='$(installdir)'/bin:$PATH'
