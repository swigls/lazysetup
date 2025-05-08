# Path
function lazysetup_root {
  echo ~/.lazysetup
}
function lazysetup_gittmp_root {
  echo $(lazysetup_root)/.gittmp
}
function lazysetup_constants_root {
  echo $(lazysetup_gittmp_root)/data/constants
}

# Shortcuts
function clone {
  remote=$1
  outdir=$2

  [ -z "$outdir" ] && outdir=$(basename "$remote")

  git clone git@github.com:"$remote" "$outdir"
}
function gpu {
  gpustat -i -p
}
function tb {
  logdir=$1

  tensorboard --logdir "$logdir" --host 0.0.0.0
}
function sshxl8 {
  last_ip=$1
  ssh -p 26882 sean@100.100.10.${last_ip} -t "tmux a || tmux"
}
function aihubdown {
  key=$1
  if [[ ! $key ]]; then
    echo "Usage: aihubdown <key>"
    return 1
  fi
  dataset=$(aihubshell -mode l | grep "$key")
  num_lines=$(echo "$dataset" | wc -l)
  if [[ $num_lines -gt 1 ]]; then
    echo "Multiple datasets found. Please specify the dataset name."
    echo "$dataset"
    return 1
  elif [[ $num_lines -eq 0 ]]; then
    echo "No dataset found with the key: $key"
    return 1
  fi
  datasetkey=$(echo "$dataset" | awk -F', ' '{print $1}')
  if [[ ! $AIHUB_API_KEY ]]; then
    echo "Please set the AIHUB_API_KEY environment variable."
    return 1
  fi
  datasetname=$(echo "$dataset" | awk -F', ' '{print $2}')
  tmp_dirname=downloading_$(datasetname)
  (
    mkdir -p "$tmp_dirname"
    cd "$tmp_dirname" || exit 1
    aihubshell -mode d -datasetkey "$datasetkey" -aihubapikey "$AIHUB_API_KEY" || exit 1
    mv * ../ || exit 1
    cd ..
    rmdir "$tmp_dirname" || exit 1
  )
}
function resrc {
  source ~/.bashrc
}

# Conda-related functions
function act {
  if [[ $1 ]]; then
    envname=$1
  else
    gitdir=$(git rev-parse --show-toplevel)
    envname=$(basename "$gitdir")
  fi
  env_exist=1
  conda activate "$envname" || env_exist=
  [[ $env_exist ]] && return 0
  # Install conda environment
  read -rp "No \"$envname\" environment, thus creating it. Which Python version? " python_version
  conda create -y -n "$envname" python=="$python_version" pip setuptools
  if [[ -e setup.py ]]; then
    (cd "$gitdir" && pip install -e .)
  elif [[ -e requirements.txt ]]; then
    (cd "$gitdir" && pip install -r requirements.txt)
  fi
  conda activate "$envname"
}
function deact {
  conda deactivate
}
function _current_conda_env {
  echo "$(conda info --envs | grep '*' | awk '{print $1}')"
}

# Installation-related functions
LAZY_INSTALL_SCRIPTS=(
  # init
  "configure/init.sh"
  "configure/constants.sh"
  # misc
  "configure/no_beep.sh"
  "configure/tmux.sh"
  "configure/ssh.sh"
  "install/lib.sh"
  # git
  "install/git.sh"
  "configure/git.sh"
  # conda
  "install/conda.sh"
  # requirements for lazyvim
  "install/ripgrep.sh"
  "install/fd.sh"
  "install/fzf.sh"
  "install/npm.sh"
  "install/aihubshell.sh"
)
LAZY_UNINSTALL_SCRIPTS=(
  "configure/init.sh"
  "configure/git.sh"
)
function _lazycd {
  tgtdir=$1
  mkdir -p "$tgtdir"
  cd "$tgtdir" || exit 1
}
function _cd_newest_lazysetup {
  dirpath=$(lazysetup_gittmp_root)
  if [[ ! -d "$dirpath" ]]; then
    [[ -e "$dirpath" ]] && rm -rf "$dirpath"
    git clone https://github.com/swigls/lazysetup "$dirpath" || exit 1
  fi
  cd "$dirpath" || exit 1
  git pull
}
function lazyupdate {
  [[ $1 == no_cd ]] && export NO_CD=1
  (
    [[ ! $NO_CD ]] && _cd_newest_lazysetup
    source libsetup.sh || exit 1

    for script in "${LAZY_INSTALL_SCRIPTS[@]}"; do
      bash "$script"
    done
  )
  source ~/.bashrc
  export NO_CD=
}
function lazyuninstall {
  [[ $1 == no_cd ]] && export NO_CD=1
  (
    [[ ! $NO_CD ]] && _cd_newest_lazysetup
    source libsetup.sh || exit 1

    export UNINSTALL=1
    for script in "${LAZY_UNINSTALL_SCRIPTS[@]}"; do
      bash "$script"
    done
    rm -rf "$(lazysetup_root)"
  )
  export NO_CD=
}
