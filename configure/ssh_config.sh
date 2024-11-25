source fn.sh || exit 1

password_check

maybe_remove ~/.ssh/config
echo \
"Host github.com
  HostName github.com
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  AddKeysToAgent yes" > ~/.ssh/config

maybe_remove ~/.ssh/id_ed25519
decrypt $(datadir)/ssh/id_ed25519 > ~/.ssh/id_ed25519
chmod 400 ~/.ssh/id_ed25519

maybe_remove ~/.ssh/id_ed25519.pub
decrypt $(datadir)/ssh/id_ed25519.pub > ~/.ssh/id_ed25519.pub
