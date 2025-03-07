# Path
function lazysetup_root {
  echo ~/.lazysetup
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
function current_conda_env {
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
function lazycd {
  tgtdir=$1
  mkdir -p "$tgtdir"
  cd "$tgtdir" || exit 1
}
function lazysourcerc {
  # Re-source the bashrc while keeping the current conda environment
  if command -v conda >/dev/null 2>&1; then
    conda_env=$(current_conda_env)
  else
    conda_env=
  fi
  source ~/.bashrc
  if [ "$conda_env" ] && [ "$conda_env" != "base" ]; then
    act "$conda_env"
  fi
}
function lazyinstall_single {
  script=$1
  bash "$script"
}
function lazyupdate {
  arg=$1
  [[ $arg == "no_cd" ]] && export NO_CD=1
  (
    if [[ ! $NO_CD ]]; then
      lazycd "$(lazysetup_root)"
    fi
    source libsetup.sh || exit 1
    make_sure_git_installed

    git_clone_lazysetup_from_remote .gitcache
    cd .gitcache || exit 1
    git pull

    for script in "${LAZY_INSTALL_SCRIPTS[@]}"; do
      lazyinstall_single "$script"
    done
  ) && lazysourcerc
}
function lazyuninstall {
  arg=$1
  [[ $arg == "no_cd" ]] && export NO_CD=1
  (
    if [[ ! $NO_CD ]]; then
      lazycd "$(lazysetup_root)"
    fi
    source libsetup.sh || exit 1
    export UNINSTALL=1
    for script in "${LAZY_UNINSTALL_SCRIPTS[@]}"; do
      lazyinstall_single "$script"
    done
    rm -rf "$(lazysetup_root)"
  )
  NO_CD=
}
