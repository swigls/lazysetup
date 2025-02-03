source libsetup.sh || exit 1

remove_or_exit $(lazysetup_root)/nvim

curl_tar_and_extract https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
mv nvim-linux64 $(lazysetup_root)/nvim

rc_append_line $(lazysetup_root)/.bashrc 'export PATH='$(lazysetup_root)'/nvim/bin:$PATH'
