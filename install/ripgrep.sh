source fn.sh || exit 1

remove_or_exit $(installdir)/bin/rg

curl_tar_and_extract "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz"
mv ripgrep-14.1.1-x86_64-unknown-linux-musl/rg $(installdir)/bin/
rm -rf ripgrep-14.1.1-x86_64-unknown-linux-musl
