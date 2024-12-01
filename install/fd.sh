source fn.sh || exit 1

remove_or_exit $(installdir)/bin/fd

curl_tar_and_extract https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
mv fd-v10.2.0-x86_64-unknown-linux-gnu/fd $(installdir)/bin/
rm -rf fd-v10.2.0-x86_64-unknown-linux-gnu
