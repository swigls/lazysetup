source libsetup.sh || exit 1

remove_or_exit $(installdir)/conda

curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $(installdir)/conda
rm -f Miniconda3-latest-Linux-x86_64.sh

rc_append_line $(installdir)/.bashrc "source $(installdir)/conda/bin/activate"
