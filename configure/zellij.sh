source libsetup.sh || exit 1

ZELLIJ_CONFIG_DIR="$(lazysetup_config_home)/zellij"

mkdir -p "$ZELLIJ_CONFIG_DIR"

cat > "$ZELLIJ_CONFIG_DIR/config.kdl" <<'EOF'
theme "codex"

themes {
    codex {
        fg 252 252 252
        bg 17 17 17
        black 17 17 17
        red 224 46 42
        green 0 162 64
        yellow 176 109 255
        blue 1 105 204
        magenta 176 109 255
        cyan 1 105 204
        white 252 252 252
        orange 176 109 255
    }
}
EOF
