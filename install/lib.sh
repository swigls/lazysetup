source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)/lib.sh"

cp lib.sh "$(lazysetup_root)/lib.sh"
rc_append_line "$(lazysetup_root)/.bashrc" "source $(lazysetup_root)/lib.sh"
