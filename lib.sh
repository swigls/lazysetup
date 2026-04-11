# Paths
function lazysetup_repo_root {
  cd "$(dirname "${BASH_SOURCE[0]}")" && pwd
}
function lazysetup_bin_dir {
  echo "$HOME/.local/bin"
}
function lazysetup_config_home {
  echo "${XDG_CONFIG_HOME:-$HOME/.config}"
}
function lazysetup_data_home {
  echo "${XDG_DATA_HOME:-$HOME/.local/share}"
}
function lazysetup_state_home {
  echo "${XDG_STATE_HOME:-$HOME/.local/state}"
}
function lazysetup_cache_home {
  echo "${XDG_CACHE_HOME:-$HOME/.cache}"
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
  if [[ $1 == "azure" ]]; then
    ssh -p 22 sean@172.184.128.202
  else
    ssh -p 26882 sean@100.100.10.${1}
  fi
}
function resrc {
  source ~/.bashrc
}


# Installation-related functions
LAZY_INSTALL_SCRIPTS=(
  # init
  "configure/init.sh"
  # misc
  "configure/no_beep.sh"
  "configure/ssh.sh"
  "install/lib.sh"
  # git
  "install/git.sh"
  "configure/git.sh"
  # uv
  "install/uv.sh"
  "install/npm.sh"
  "install/zellij.sh"
  "install/helix.sh"
  "install/gitui.sh"
  "install/s5cmd.sh"
  "configure/helix.sh"
)
function _lazycd {
  tgtdir=$1
  mkdir -p "$tgtdir"
  cd "$tgtdir" || exit 1
}
function lazyupdate {
  (
    # Resolve the repo from this sourced file so lazyupdate works from any cwd.
    cd "$(lazysetup_repo_root)" || exit 1
    git pull || exit 1
    source libsetup.sh || exit 1

    for script in "${LAZY_INSTALL_SCRIPTS[@]}"; do
      bash "$script"
    done
  )
  source ~/.bashrc
}
