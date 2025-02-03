source libsetup.sh || exit 1

remove_or_exit "$(installdir)/exe.sh"

cp exe.sh "$(installdir)/exe.sh"
rc_append_line "$(installdir)/.bashrc" "source $(installdir)/exe.sh":\$PATH
