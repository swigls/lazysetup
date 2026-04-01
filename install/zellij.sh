source libsetup.sh || exit 1

mkdir -p "$(lazysetup_bin_dir)"
tmpdir=$(mktemp -d)
(
  cd "$tmpdir" || exit 1
  curl_tar_and_extract "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
  install -m 755 zellij "$(lazysetup_bin_dir)/zellij"
)
rm -rf "$tmpdir"
