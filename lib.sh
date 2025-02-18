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
INSTALL_SCRIPTS=(
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
UNINSTALL_SCRIPTS=(
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
  if [ "$conda_env" ]; then
    act "$conda_env"
  fi
}
function lazyinstall_single {
  script=$1
  (
    bash "$script"
  )
}
function lazyupdate {
  (
    lazycd "$(lazysetup_root)"
    # If git is not installed, install it
    if ! command -v git >/dev/null 2>&1; then
      lazyinstall_single "install/git.sh"
      lazysourcerc
    fi

    # cd to the git-cache dir for lazysetup
    if [[ ! -d .gitcache ]]; then
      # If no git cache found, install all
      git clone https://github.com/swigls/lazysetup .gitcache || exit 1
      changes=("${INSTALL_SCRIPTS[@]}")
    fi
    cd .gitcache || exit 1

    # Check git remote update, and sync
    git fetch
    [ -z "$changes" ] && changes=$(git diff --name-only master origin/master)
    if [[ -z "$changes" ]]; then
      echo "No git changes detected"
      exit 1
    fi
    git pull origin master

    # Install the scripts that have changes
    # (always jpdate lazyvim config)
    if [[ ! " ${changes[*]} " == " configure/lazyvim.sh " ]]; then
      changes+=("configure/lazyvim.sh")
    fi
    echo "Changes detected: ${changes[*]}"
    for script in "${INSTALL_SCRIPTS[@]}"; do
      if [[ " ${changes[*]} " == *" ${script} "* ]]; then
        lazyinstall_single "$script"
      fi
    done
  ) && lazysourcerc # Re-source the bashrc if changes are made
}
function lazyuninstall {
  arg=$1
  [[ $arg == "no_cd" ]] && export NO_CD=1
  (
    if [[ ! $NO_CD ]]; then
      cd "$(lazysetup_root)" || exit 1
    fi
    export UNINSTALL=1
    for script in $UNINSTALL_SCRIPTS; do
      lazyinstall_single "$script"
    done
    rm -rf "$(lazysetup_root)"
  )
}
