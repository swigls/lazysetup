source libsetup.sh || exit 1

curl -o "aihubshell" https://api.aihub.or.kr/api/aihubshell.do

mv aihubshell "$(lazysetup_root)/bin/aihubshell"
chmod +x "$(lazysetup_root)/bin/aihubshell"

rc_append_line "$(lazysetup_root)/.bashrc" "source $(lazysetup_root)/bin/aihubshell"
