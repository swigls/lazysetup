source libsetup.sh || exit 1

arch=$(uname -m)
case "$arch" in
  x86_64) asset=difft-x86_64-unknown-linux-gnu.tar.gz ;;
  aarch64) asset=difft-aarch64-unknown-linux-gnu.tar.gz ;;
  *)
    echo "difftastic: unsupported architecture: $arch (Linux x86_64 and aarch64 only)" >&2
    exit 1
    ;;
esac

mkdir -p "$(lazysetup_bin_dir)"
tmpdir=$(mktemp -d)
(
  cd "$tmpdir" || exit 1
  curl_tar_and_extract "https://github.com/Wilfred/difftastic/releases/latest/download/${asset}"
  install -m 755 difft "$(lazysetup_bin_dir)/difft"
)
rm -rf "$tmpdir"
