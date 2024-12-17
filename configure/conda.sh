source fn.sh || exit 1

remove_or_exit "$(installdir)"/fn.sh

act_fn='function act {
  if [[ $1 ]]; then
    envname=$1
  else
    envname=$(basename $(git rev-parse --show-toplevel))
  fi
  not_exist=
  conda activate $envname || not_exist=1
  if [[ $not_exist ]]; then
    read -p "No \"$envname\" environment, thus creating it. Which Python version? " python_version
    conda create -n $envname python==$python_version pip setuptools
    conda activate $envname
  fi
}'
deact_fn='function deact {
  conda deactivate
}'
rc_append_line "$(installdir)"/fn.sh "$act_fn"
rc_append_line "$(installdir)"/fn.sh "$deact_fn"
rc_append_line "$(installdir)"/.bashrc "source $(installdir)/fn.sh"
