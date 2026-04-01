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
  "install/delta.sh"
  "install/lazygit.sh"
  "install/s5cmd.sh"
  "configure/helix.sh"
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
