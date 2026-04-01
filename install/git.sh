source libsetup.sh || exit 1

command -v git &&
  [[ $(version "$(git --version | cut -d" " -f3)") -gt $(version 2.19.0) ]] &&
  echo "git >= 2.19.0 already installed" && exit 0

mkdir -p "$(lazysetup_bin_dir)"
curl_tar_and_extract "https://github.com/git/git/archive/refs/tags/v2.47.0.tar.gz"
cd git-2.47.0 || exit 1
make prefix="$HOME/.local"
make prefix="$HOME/.local" install

rm -rf git-2.47.0
