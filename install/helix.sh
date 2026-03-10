source libsetup.sh || exit 1

HELIX_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
HELIX_DIR="$(lazysetup_root)/helix"

remove_or_exit "$HELIX_DIR"

curl_tar_and_extract "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
mv "helix-${HELIX_VERSION}-x86_64-linux" "$HELIX_DIR"

ln -sf "$HELIX_DIR/hx" "$(lazysetup_root)/bin/hx"

rc_append_line "$(lazysetup_root)/.bashrc" "export HELIX_RUNTIME=$HELIX_DIR/runtime"
