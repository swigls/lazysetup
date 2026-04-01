source libsetup.sh || exit 1

mkdir -p "$(lazysetup_bin_dir)"
curl_tar_and_extract "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz"
mv zellij "$(lazysetup_bin_dir)/"
