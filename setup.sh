source fn.sh || exit 1

if [[ $1 ]]; then
  case $1 in
  # u or U or uninstall or UNINSTALL
  [uU] | uninstall | UNINSTALL) export UNINSTALL=1 ;;
  [iI] | install | INSTALL) export INSTALL=1 ;;
  *)
    echo "Invalid argument: $1"
    echo "First argument means global set for installation. It must be either i(install) or u(uninstall) or empty"
    exit 1
    ;;
  esac
fi

## Uninstallation
if [[ $UNINSTALL ]]; then
  bash configure/init.sh
  bash configure/git.sh
  rm -rf "$(installdir)"
  exit 0
fi

## Installation
# init
bash configure/init.sh

# misc
bash configure/no_beep.sh
bash configure/tmux.sh
bash configure/ssh_config.sh
bash install/bin.sh

# git
bash install/git.sh
bash configure/git.sh

# conda
bash install/conda.sh
bash configure/conda.sh

# nvim & lazyvim
bash install/nvim.sh
bash install/lazygit.sh
bash install/ripgrep.sh
bash install/fd.sh
bash install/npm.sh
bash install/lazyvim.sh
