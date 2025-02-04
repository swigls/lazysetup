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
  "install/exe.sh"
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
  "install/npm.sh"
  # lazyvim
  "install/lazyvim.sh"
  "configure/lazyvim.sh"
)
function lazysourcerc {
  # Re-source the bashrc while keeping the current conda environment
  if command -v conda >/dev/null 2>&1; then
    conda_env=$(current_conda_env)
  else
    conda_env=
  fi
  source ~/.bashrc
  if [ "$conda_env" ]; then
    conda activate "$conda_env"
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
    cd "$(lazysetup_root)" || exit 1
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
    [ -z "$changes" ] && changes=(git diff --name-only master origin/master)
    if [[ -z "$changes" ]]; then
      echo "No git changes detected"
      exit 1
    fi
    git pull origin master

    # Install the scripts that have changes
    if [[ ! " ${changes[*]} " == " configure/lazyvim.sh " ]]; then
      for change in "${changes[@]}"; do
        if [[ "$change" == "data/lazyvim/"* ]]; then
          changes+=("configure/lazyvim.sh")
          break
        fi
      done
    fi
    for script in "${INSTALL_SCRIPTS[@]}"; do
      if [[ " ${changes[*]} " == *" ${script} "* ]]; then
        lazyinstall_single "$script"
      fi
    done
  ) && lazysourcerc # Re-source the bashrc if changes are made
}
function lazyuninstall {
  (
    cd "$(lazysetup_root)" || exit 1
    export UNINSTALL=1
    bash configure/init.sh
    bash configure/git.sh
    rm -rf "$(lazysetup_root)"
  )
}
