# Path
function lazysetup_root {
  echo ~/.lazysetup
}
function lazysetup_gittmp_root {
  echo $(lazysetup_root)/.gittmp
}
function lazysetup_constants_root {
  echo $(lazysetup_root)/data/constants
}

# Constants
AIHUB_API_KEY="56396CEF-18C4-4181-8F5B-43BF96DE48AD"

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

# Privacy
function password_check {
  [ "$PASSWORD" ] && return 0
  read -rs -p $'Type in the password for private keys and repos: \n' password
  export PASSWORD=$password
  check_result=$(decrypt data/password)
  if [[ ! $check_result == correct ]]; then
    echo "Password incorrect."
    exit 1
  fi
}
function encrypt {
  [ ! "$PASSWORD" ] && password_check
  echo -n "$1" | openssl aes-256-cbc -a -pbkdf2 -pass pass:"$PASSWORD" | tr -d '\n' >"$2"
}
function decrypt {
  [ ! "$PASSWORD" ] && password_check
  openssl aes-256-cbc -d -a -pbkdf2 -pass pass:"$PASSWORD" <"$1"
}

# Constants
function AIHUB_API_KEY {
  decrypt $(lazysetup_constants_root)/AIHUB_API_KEY
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
function _lazysourcerc {
  deact
  if command -v conda >/dev/null 2>&1; then
    conda_env=$(_current_conda_env)
  else
    conda_env=
  fi
  source ~/.bashrc
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
