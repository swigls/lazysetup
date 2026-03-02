source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)"/bin/zellij

curl_tar_and_extract "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz"
mv zellij "$(lazysetup_root)"/bin/

# Install zellij-attention plugin
plugins_dir="$(lazysetup_root)/xdg_base/.config/zellij/plugins"
mkdir -p "$plugins_dir"
curl -fL "https://github.com/KiryuuLight/zellij-attention/releases/latest/download/zellij-attention.wasm" \
    -o "$plugins_dir/zellij-attention.wasm"
