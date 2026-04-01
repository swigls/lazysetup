source libsetup.sh || exit 1

mkdir -p ~/.ssh
touch ~/.ssh/config
chmod 600 ~/.ssh/config

if ! grep -q '^Host github.com$' ~/.ssh/config; then
cat >> ~/.ssh/config <<'EOF'
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  AddKeysToAgent yes
EOF
fi

decrypt data/ssh/id_ed25519 > ~/.ssh/id_ed25519
chmod 400 ~/.ssh/id_ed25519

decrypt data/ssh/id_ed25519.pub > ~/.ssh/id_ed25519.pub
cp -f ~/.ssh/id_ed25519.pub ~/.ssh/authorized_keys
chmod 644 ~/.ssh/id_ed25519.pub ~/.ssh/authorized_keys
