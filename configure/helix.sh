source ~/.bashrc
source libsetup.sh || exit 1

HELIX_CONFIG_DIR="$(lazysetup_root)/xdg_base/.config/helix"

if [[ $UNINSTALL ]]; then
  rm -f "$HELIX_CONFIG_DIR/config.toml"
  rm -f "$HELIX_CONFIG_DIR/languages.toml"
  echo "Removed helix config files."
  exit 0
fi

mkdir -p "$HELIX_CONFIG_DIR"

# (1) Theme
cat > "$HELIX_CONFIG_DIR/config.toml" << 'EOF'
theme = "kanagawa"
EOF

# (2) Python LSP: pyright + ruff
cat > "$HELIX_CONFIG_DIR/languages.toml" << 'EOF'
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

# Install pyright and ruff if pip/npm available
if command -v pip >/dev/null 2>&1; then
  pip install ruff pyright
elif command -v pip3 >/dev/null 2>&1; then
  pip3 install ruff pyright
else
  echo "Warning: pip not found. Install ruff and pyright manually."
fi
