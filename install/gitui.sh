source libsetup.sh || exit 1

GITUI_VERSION=$(curl -s https://api.github.com/repos/gitui-org/gitui/releases/latest | grep '"tag_name"' | cut -d'"' -f4)

curl_tar_and_extract "https://github.com/gitui-org/gitui/releases/download/${GITUI_VERSION}/gitui-linux-x86_64.tar.gz"
mv ./gitui "$(lazysetup_root)/bin/gitui"
