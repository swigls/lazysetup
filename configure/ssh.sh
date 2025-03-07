source libsetup.sh || exit 1

remove_or_exit "$(lazysetup_root)"/.ssh

mkdir -p "$(lazysetup_root)"/.ssh
echo \
  "Host github.com
  HostName github.com
  IdentityFile $(lazysetup_root)/.ssh/id_ed25519
  IdentitiesOnly yes
  AddKeysToAgent yes" >"$(lazysetup_root)"/.ssh/config

decrypt data/ssh/id_ed25519 >"$(lazysetup_root)"/.ssh/id_ed25519
chmod 400 "$(lazysetup_root)"/.ssh/id_ed25519

decrypt data/ssh/id_ed25519.pub >"$(lazysetup_root)"/.ssh/id_ed25519.pub
cp -f "$(lazysetup_root)"/.ssh/id_ed25519.pub "$(lazysetup_root)"/.ssh/authorized_keys
mkdir -p ~/.ssh
ln -srf "$(lazysetup_root)"/.ssh/authorized_keys ~/.ssh/authorized_keys

rc_append_line "$(lazysetup_root)"/.bashrc "export SSH_CONFIG_FILE=$(lazysetup_root)/.ssh/config"
rc_append_line "$(lazysetup_root)"/.bashrc "export GIT_SSH_COMMAND='ssh -F $(lazysetup_root)/.ssh/config'"
