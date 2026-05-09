source ~/.bashrc
source libsetup.sh || exit 1

HELIX_CONFIG_DIR="$(lazysetup_config_home)/helix"

mkdir -p "$HELIX_CONFIG_DIR"
mkdir -p "$HELIX_CONFIG_DIR/themes"

cat > "$HELIX_CONFIG_DIR/config.toml" <<'EOF'
theme = "codex"
EOF

cat > "$HELIX_CONFIG_DIR/themes/codex.toml" <<'EOF'
"ui.background" = { bg = "surface" }
"ui.text" = "ink"
"ui.text.focus" = { fg = "ink", modifiers = ["bold"] }
"ui.cursor" = { fg = "surface", bg = "ink" }
"ui.cursorline.primary" = { bg = "cursorline" }
"ui.selection" = { bg = "selection" }
"ui.statusline" = { fg = "ink", bg = "surface" }
"ui.statusline.insert" = { fg = "surface", bg = "accent" }
"ui.statusline.select" = { fg = "surface", bg = "skill" }
"ui.help" = { fg = "ink", bg = "surface" }
"ui.menu" = { fg = "ink", bg = "surface" }
"ui.menu.selected" = { fg = "surface", bg = "accent" }
"ui.linenr" = "muted"
"ui.linenr.selected" = "ink"
"ui.virtual" = "muted"
"ui.virtual.ruler" = { bg = "cursorline" }
"ui.virtual.inlay-hint" = "skill"
"ui.window" = "muted"
"ui.popup" = { fg = "ink", bg = "surface" }
"ui.highlight" = { bg = "selection" }
"ui.cursor.match" = { fg = "accent", modifiers = ["bold"] }

"diagnostic.error" = { underline = { color = "diffRemoved", style = "curl" } }
"diagnostic.warning" = { underline = { color = "skill", style = "curl" } }
"diagnostic.info" = { underline = { color = "accent", style = "curl" } }
"diagnostic.hint" = { underline = { color = "muted", style = "curl" } }
error = "diffRemoved"
warning = "skill"
info = "accent"
hint = "muted"

"diff.plus" = "diffAdded"
"diff.minus" = "diffRemoved"
"diff.delta" = "accent"

keyword = "skill"
type = "accent"
function = "ink"
variable = "ink"
constant = "accent"
string = "diffAdded"
comment = { fg = "muted", modifiers = ["italic"] }

[palette]
surface = "#111111"
ink = "#fcfcfc"
accent = "#0169cc"
diffAdded = "#00a240"
diffRemoved = "#e02e2a"
skill = "#b06dff"
muted = "#7a7a7a"
cursorline = "#1b1b1b"
selection = "#013f7a"
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
