source fn.sh || exit 1

remove_or_exit ~/.nvim

curl_tar_and_extract https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz

mv nvim-linux64 ~/.nvim

rc_append ~/.bashrc "PATH=~/.nvim/bin:\$PATH"
