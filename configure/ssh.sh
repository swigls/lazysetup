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

tmp_private_key=$(mktemp)
tmp_public_key=$(mktemp)

decrypt data/ssh/id_ed25519 > "$tmp_private_key"
install -m 400 "$tmp_private_key" ~/.ssh/id_ed25519

decrypt data/ssh/id_ed25519.pub > "$tmp_public_key"
install -m 644 "$tmp_public_key" ~/.ssh/id_ed25519.pub
cp -f ~/.ssh/id_ed25519.pub ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

rm -f "$tmp_private_key" "$tmp_public_key"
