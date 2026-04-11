source libsetup.sh || exit 1

rc_append_line ~/.bashrc "source \"$(lazysetup_repo_root)/lib.sh\""
