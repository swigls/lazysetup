source fn.sh || exit 1

wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
rm -f nvim-linux64.tar.gz*

maybe_remove ~/.nvim
maybe_remove ~/.nvim/nvim-linux64
mv nvim-linux64 ~/.nvim

rc_append ~/.bashrc "PATH=\$PATH:~/.nvim/bin"
