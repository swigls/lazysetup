source fn.sh || exit 1

maybe_remove ~/.bin/lazygit

lazygit_ver=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl_tar_and_extract "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_ver}/lazygit_${lazygit_ver}_Linux_x86_64.tar.gz"
mv lazygit_${lazygit_ver}_Linux_x86_64 lazygit

mkdir -p ~/.bin
install lazygit -D -t ~/.bin
rm -f lazygit
