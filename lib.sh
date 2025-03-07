# Path
function lazysetup_root {
  echo ~/.lazysetup
}
function lazysetup_gittmp_root {
  echo $(lazysetup_root)/.gittmp
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

# Conda-related functions
function act {
  if [[ $1 ]]; then
    envname=$1
  else
    envname=$(basename "$(git rev-parse --show-toplevel)")
  fi
  not_exist=
  conda activate "$envname" || not_exist=1
  if [[ $not_exist ]]; then
    read -rp "No \"$envname\" environment, thus creating it. Which Python version? " python_version
    conda create -n "$envname" python=="$python_version" pip setuptools
    conda activate "$envname"
  fi
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
  "install/nvim.sh"
  "install/lazygit.sh"
  "install/ripgrep.sh"
  "install/fd.sh"
  "install/fzf.sh"
  "install/npm.sh"
  # lazyvim
  "configure/lazyvim.sh"
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
  make_sure_git_installed
  dirpath=$(lazysetup_gittmp_root)
  if [[ ! -d "$dirpath" ]]; then
    [[ -e "$dirpath" ]] && rm -rf "$dirpath"
    git clone https://github.com/swigls/lazysetup "$dirpath" || exit 1
  fi
  cd "$dirpath" || exit 1
  git pull
}
function _lazysourcerc {
  # Re-source the bashrc while keeping the current conda environment
  if command -v conda >/dev/null 2>&1; then
    conda_env=$(_current_conda_env)
  else
    conda_env=
  fi
  source ~/.bashrc
  if [ "$conda_env" ] && [ "$conda_env" != "base" ]; then
    act "$conda_env"
  fi
}
function _lazyinstall_single {
  script=$1
  bash "$script"
}
function lazyupdate {
  [[ $1 == no_cd ]] && export NO_CD=1
  (
    [[ ! $NO_CD ]] && _cd_newest_lazysetup
    source libsetup.sh || exit 1

    for script in "${LAZY_INSTALL_SCRIPTS[@]}"; do
      _lazyinstall_single "$script"
    done
  ) && _lazysourcerc
  export NO_CD=
}
function lazyuninstall {
  [[ $1 == no_cd ]] && export NO_CD=1
  (
    [[ ! $NO_CD ]] && _cd_newest_lazysetup
    source libsetup.sh || exit 1
    export UNINSTALL=1

    for script in "${LAZY_UNINSTALL_SCRIPTS[@]}"; do
      _lazyinstall_single "$script"
    done
    rm -rf "$(lazysetup_root)"
  )
  export NO_CD=
}
