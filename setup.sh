source fn.sh || exit 1

# Argument parser
programname=$0
function usage {
    echo ""
    echo "Setup development environments by executing a single script."
    echo ""
    echo "usage: $programname --remove_existing bool"
    echo ""
    echo "  --remove_existing bool  Whether to remove existing files to setup."
    echo "                          (example: y/Y to yes, n/N to no)"
    echo ""
}
while [ $# -gt 0 ]; do
  if [[ $1 == "--help" ]]; then
    usage
    exit 0
  elif [[ $1 == "--"* ]]; then
    v="${1/--/}"
    declare "$v"="$2"
    shift
  fi
  shift
done

password_check
maybe_ask_preset_envvar remove_existing

# Installation
bash misc/*.sh

bash nvim/0_nvim.sh
bash nvim/1_lazygit.sh
bash nvim/2_lazyvim.sh

# Sourcing
source ~/.bashrc
source ~/.inputrc
source ~/.vimrc
