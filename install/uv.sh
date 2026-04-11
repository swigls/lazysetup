source libsetup.sh || exit 1

if command -v uv >/dev/null 2>&1; then
  exit 0
fi

curl -LsSf https://astral.sh/uv/install.sh | sh

rc_append_line ~/.bashrc 'export PATH="$HOME/.cargo/bin:$PATH"'
