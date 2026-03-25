source libsetup.sh || exit 1

# Configure zellaude plugin in zellij default layout
ZELLIJ_LAYOUT_DIR="$HOME/.config/zellij/layouts"
ZELLIJ_LAYOUT_FILE="$ZELLIJ_LAYOUT_DIR/default.kdl"
ZELLAUDE_PLUGIN='plugin location="https://github.com/ishefi/zellaude/releases/latest/download/zellaude.wasm"'

if [[ $UNINSTALL ]]; then
    if [[ -f "$ZELLIJ_LAYOUT_FILE" ]]; then
        python3 << 'EOF'
import os, re

layout_file = os.path.expanduser('~/.config/zellij/layouts/default.kdl')
if not os.path.exists(layout_file):
    exit(0)

with open(layout_file) as f:
    content = f.read()

# Remove the default_tab_template block added by zellaude
pattern = r'\ndefault_tab_template \{[^}]*zellaude[^}]*\{[^}]*\}[^}]*\}\n?'
new_content = re.sub(pattern, '\n', content, flags=re.DOTALL)

with open(layout_file, 'w') as f:
    f.write(new_content)

print(f"Removed zellaude config from {layout_file}")
EOF
    fi
else
    mkdir -p "$ZELLIJ_LAYOUT_DIR"
    touch "$ZELLIJ_LAYOUT_FILE"

    python3 << 'EOF'
import os

layout_file = os.path.expanduser('~/.config/zellij/layouts/default.kdl')

with open(layout_file) as f:
    content = f.read()

if 'zellaude' in content:
    print(f"zellaude already configured in {layout_file}")
    exit(0)

zellaude_block = '''
default_tab_template {
    pane size=1 borderless=true {
        plugin location="https://github.com/ishefi/zellaude/releases/latest/download/zellaude.wasm"
    }
    children
}
'''

with open(layout_file, 'a') as f:
    f.write(zellaude_block)

print(f"Added zellaude to {layout_file}")
EOF
fi
