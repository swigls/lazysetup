source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)/bin/fzf"

curl_tar_and_extract https://github.com/junegunn/fzf/releases/download/v0.59.0/fzf-0.59.0-linux_amd64.tar.gz
mv ./fzf "$(lazysetup_root)/bin/fzf"

rc_append_line "$(lazysetup_root)/.bashrc"  'eval "$(fzf --bash)"'
