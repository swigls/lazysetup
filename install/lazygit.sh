source fn.sh || exit 1

maybe_remove ~/.bin/lazygit

curl_tar_and_extract "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz" lazygit_tmp

mkdir -p ~/.bin
mv lazygit_tmp/lazygit ~/.bin/
rm -rf lazygit_tmp

mkdir -p ~/.config/lazygit
touch ~/.config/lazygit/config.yaml
