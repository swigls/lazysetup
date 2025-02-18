source libsetup.sh || exit 1

if [ -e "$(lazysetup_root)/conda" ]; then
  exit 0
fi

curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p "$(lazysetup_root)/conda"
rm -f Miniconda3-latest-Linux-x86_64.sh

rc_append_line "$(lazysetup_root)/.bashrc" "source $(lazysetup_root)/conda/bin/activate"
