source fn.sh || exit 1

maybe_remove ~/.nvim
maybe_remove ~/.nvim/nvim-linux64

curl_tar_and_extract https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz

mv nvim-linux64 ~/.nvim

rc_append ~/.bashrc "PATH=\$PATH:~/.nvim/bin"
