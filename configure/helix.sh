source ~/.bashrc
source libsetup.sh || exit 1

HELIX_CONFIG_DIR="$(lazysetup_config_home)/helix"

mkdir -p "$HELIX_CONFIG_DIR"

cat > "$HELIX_CONFIG_DIR/config.toml" <<'EOF'
theme = "gruvbox-material"
EOF

cat > "$HELIX_CONFIG_DIR/languages.toml" <<'EOF'
[[language]]
name = "python"
language-servers = ["pyright", "ruff"]

[language-server.ruff]
command = "ruff"
args = ["server"]

[language-server.pyright]
command = "pyright-langserver"
args = ["--stdio"]
EOF

rc_append_line ~/.bashrc 'export EDITOR="hx"'

if command -v pip >/dev/null 2>&1; then
  pip install ruff pyright
elif command -v pip3 >/dev/null 2>&1; then
  pip3 install ruff pyright
else
  echo "Warning: pip not found. Install ruff and pyright manually."
fi
