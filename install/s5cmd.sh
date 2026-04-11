source libsetup.sh || exit 1

S5CMD_VERSION=$(curl -s https://api.github.com/repos/peak/s5cmd/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
S5CMD_VERSION_NO_V=${S5CMD_VERSION#v}

mkdir -p "$(lazysetup_bin_dir)"
curl_tar_and_extract "https://github.com/peak/s5cmd/releases/download/${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION_NO_V}_Linux-64bit.tar.gz"
mv s5cmd "$(lazysetup_bin_dir)/s5cmd"
