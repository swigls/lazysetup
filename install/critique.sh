source libsetup.sh || exit 1

if ! command -v bun >/dev/null 2>&1; then
  curl -fsSL https://bun.sh/install | bash
fi

export PATH="$HOME/.bun/bin:$PATH"

bun install -g critique

mkdir -p "$(lazysetup_bin_dir)"
if [ -x "$HOME/.bun/bin/critique" ] && [ -x "$HOME/.bun/bin/bun" ]; then
  ln -sf "$HOME/.bun/bin/bun" "$(lazysetup_bin_dir)/bun"
  ln -sf "$HOME/.bun/bin/critique" "$(lazysetup_bin_dir)/critique"
else
  echo "critique: installation succeeded but executable not found in PATH" >&2
  exit 1
fi
