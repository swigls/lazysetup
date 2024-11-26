source fn.sh || exit 1

act_fn='function act {
  envname=$(basename $(git rev-parse --show-toplevel))
  not_exist=
  conda activate $envname || not_exist=1
  if [[ $not_exist ]]; then
    read -p "No \"$envname\" environment, thus creating it. Which Python version? " python_version
    conda create -n $envname python==$python_version pip setuptools
  fi
}'
deact_fn='function deact {
  conda deactivate
}'
rc_append ~/.bashrc "$act_fn"
rc_append ~/.bashrc "$deact_fn"
