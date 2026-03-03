source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)"/bin/zellij

curl_tar_and_extract "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz"
mv zellij "$(lazysetup_root)"/bin/
