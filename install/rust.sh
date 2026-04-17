source libsetup.sh || exit 1

if command -v cargo >/dev/null 2>&1; then
  echo "Rust/Cargo already installed"
  exit 0
fi

echo "Installing Rust/Cargo..."
# -y: prompt 없이 설치, --no-modify-path: 스크립트에서 직접 관리하기 위해 자동 수정 방지
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

# 현재 세션에 적용
export PATH="$HOME/.cargo/bin:$PATH"

# .bashrc에 PATH 추가 (중복 방지는 rc_append_line이 처리)
rc_append_line ~/.bashrc 'export PATH="$HOME/.cargo/bin:$PATH"'
