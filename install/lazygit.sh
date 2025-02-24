source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)"/lazygit

curl_tar_and_extract "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz" lazygit_tmp

mkdir -p "$(lazysetup_root)"/lazygit/bin
mv lazygit_tmp/lazygit "$(lazysetup_root)"/lazygit/bin/
rm -rf lazygit_tmp

touch "$(lazysetup_root)"/lazygit/config.yml

rc_append_line "$(lazysetup_root)"/.bashrc "export PATH=$(lazysetup_root)/lazygit/bin":'$PATH'
rc_append_line "$(lazysetup_root)"/.bashrc "export CONFIG_DIR=$(lazysetup_root)/lazygit"
