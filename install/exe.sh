source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)/exe.sh"

cp exe.sh "$(lazysetup_root)/exe.sh"
rc_append_line "$(lazysetup_root)/.bashrc" "source $(lazysetup_root)/exe.sh":\$PATH
