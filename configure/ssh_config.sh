source fn.sh || exit 1

remove_or_exit $(installdir)/.ssh

mkdir -p $(installdir)/.ssh
echo \
  "Host github.com
  HostName github.com
  IdentityFile $(installdir)/.ssh/id_ed25519
  IdentitiesOnly yes
  AddKeysToAgent yes" >$(installdir)/.ssh/config

decrypt data/ssh/id_ed25519 >$(installdir)/.ssh/id_ed25519
chmod 400 $(installdir)/.ssh/id_ed25519

decrypt datadir/ssh/id_ed25519.pub >$(installdir)/.ssh/id_ed25519.pub
decrypt datadir/ssh/id_ed25519.pub >$(installdir)/.ssh/authorized_keys

rc_append_line $(installdir)/.bashrc "export SSH_CONFIG_FILE=$(installdir)/.ssh/config"
rc_append_line $(installdir)/.bashrc "export GIT_SSH_COMMAND='ssh -F $(installdir)/.ssh/config'"
