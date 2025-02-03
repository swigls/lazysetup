source libsetup.sh || exit 1

command -v git &&
  [[ $(version "$(git --version | cut -d" " -f3)") -gt $(version 2.19.0) ]] &&
  echo "git >= 2.19.0 already installed" && exit 0

remove_or_exit $(lazysetup_root)/bin/git

curl_tar_and_extract "https://github.com/git/git/archive/refs/tags/v2.47.0.tar.gz"
cd git-2.47.0
make prefix=$(lazysetup_root)/bin/git
make prefix=$(lazysetup_root)/bin/git install

rm -rf git-2.47.0

rc_append_line $(lazysetup_root)/.bashrc 'export PATH='$(lazysetup_root)'/bin/git:$PATH'
