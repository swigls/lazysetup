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
    return 0
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
mkdir -p ~/.bin
cp bin/* ~/.bin/
rc_append ~/.bashrc "PATH=~/.bin:\$PATH"

bash misc/*.sh

bash nvim/nvim.sh
bash nvim/git.sh
bash nvim/lazygit.sh
bash nvim/ripgrep.sh
bash nvim/fd.sh
bash nvim/lazyvim.sh
