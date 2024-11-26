source fn.sh || exit 1

env_exist_fn="function env_exist {
  interested_env=\$1
  conda env list | while read line; do
    env_path=\$(echo \"\$line\" | awk '{print \$NF}')
    env_basename=\$(basename \"\$env_path\")
    [ -z \$env_basename ] && continue
    [ \"\$env_basename\" == \"\$interested_env\" ] && echo \"exist\"; break
  done
}"
act_fn="function act {
  envname=\$(basename \$(git rev-parse --show-toplevel))
  if [ -z \$(env_exist \$envname) ]; then
    read -p \"\$envname not existing, thus creating it. Python version? \" python_version
    conda create -n \$envname python==\$python_version pip setuptools
  fi
  conda activate \$(basename \$(git rev-parse --show-toplevel))
}"
deact_fn="function deact {
  conda deactivate
}"
rc_append ~/.bashrc "$env_exist_fn"
rc_append ~/.bashrc "$act_fn"
rc_append ~/.bashrc "$deact_fn"
