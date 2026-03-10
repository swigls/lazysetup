source libsetup.sh || exit 1

rc_append_line "$(lazysetup_root)/.bashrc" "export COLORTERM=truecolor"
