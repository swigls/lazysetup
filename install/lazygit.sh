source fn.sh || exit 1

remove_or_exit $(installdir)/lazygit

curl_tar_and_extract "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz" lazygit_tmp

mkdir -p $(installdir)/lazygit/bin
mv lazygit_tmp/lazygit $(installdir)/lazygit/bin/
rm -rf lazygit_tmp

touch $(installdir)/lazygit/config.yml

rc_append_line $(installdir)/.bashrc "export PATH=$(installdir)/lazygit/bin":'$PATH'
rc_append_line $(installdir)/.bashrc "export LD_CONFIG_FILE=$(installdir)/lazygit/config.yml"
