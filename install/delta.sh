source libsetup.sh || exit 1

DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep '"tag_name"' | cut -d'"' -f4)

mkdir -p "$(lazysetup_bin_dir)"
curl_tar_and_extract "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
mv delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta "$(lazysetup_bin_dir)/delta"
rm -rf delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu
