source libsetup.sh || exit 1

arch=$(uname -m)
case "$arch" in
  x86_64) asset=gitui-linux-x86_64.tar.gz ;;
  aarch64) asset=gitui-linux-aarch64.tar.gz ;;
  armv7l) asset=gitui-linux-armv7.tar.gz ;;
  arm*) asset=gitui-linux-arm.tar.gz ;;
  *)
    echo "gitui: unsupported architecture: $arch" >&2
    exit 1
    ;;
esac

mkdir -p "$(lazysetup_bin_dir)"
tmpdir=$(mktemp -d)
(
  cd "$tmpdir" || exit 1
  curl_tar_and_extract "https://github.com/gitui-org/gitui/releases/latest/download/${asset}"
  install -m 755 gitui "$(lazysetup_bin_dir)/gitui"
)
rm -rf "$tmpdir"
