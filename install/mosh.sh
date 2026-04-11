source libsetup.sh || exit 1

if command -v mosh >/dev/null 2>&1; then
  echo "mosh already installed"
  exit 0
fi

sudo apt-get install -y mosh
