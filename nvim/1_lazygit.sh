source fn.sh || exit 1

maybe_remove ~/.bin/lazygit

lazygit_ver=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_ver}/lazygit_${lazygit_ver}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
rm -f lazygit.tar.gz

mkdir -p ~/.bin
install lazygit -D -t ~/.bin
rm -f lazygit

rc_append ~/.bashrc "PATH=\$PATH:~/.bin"
