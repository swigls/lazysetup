source fn.sh || exit 1

remove_or_exit ~/.bin

mkdir -p ~/.bin
cp bin/* ~/.bin/
rc_append ~/.bashrc 'PATH=~/.bin:$PATH'
