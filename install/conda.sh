source fn.sh || exit 1

remove_or_exit ~/.conda_venv

curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/.conda_venv
rm -f Miniconda3-latest-Linux-x86_64.sh

rc_append_line ~/.bashrc "source ~/.conda_venv/bin/activate"
