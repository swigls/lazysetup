source libsetup.sh || exit 1

LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
LAZYGIT_VERSION_NUM=${LAZYGIT_VERSION#v}

mkdir -p "$(lazysetup_bin_dir)"
curl_tar_and_extract "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION_NUM}_Linux_x86_64.tar.gz"
mv lazygit "$(lazysetup_bin_dir)/lazygit"
