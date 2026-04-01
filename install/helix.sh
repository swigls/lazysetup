source libsetup.sh || exit 1

HELIX_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
HELIX_DIR="$(lazysetup_data_home)/helix"

curl_tar_and_extract "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
rm -rf "$HELIX_DIR"
mkdir -p "$(dirname "$HELIX_DIR")" "$(lazysetup_bin_dir)"
mv "helix-${HELIX_VERSION}-x86_64-linux" "$HELIX_DIR"

ln -sf "$HELIX_DIR/hx" "$(lazysetup_bin_dir)/hx"

rc_append_line ~/.bashrc "export HELIX_RUNTIME=$HELIX_DIR/runtime"
