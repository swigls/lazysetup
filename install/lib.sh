source libsetup.sh || exit 1

cp -f lib.sh "$(lazysetup_root)/lib.sh"
rc_append_line "$(lazysetup_root)/.bashrc" "source $(lazysetup_root)/lib.sh"
