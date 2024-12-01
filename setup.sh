source fn.sh || exit 1

password_check
maybe_ask_preset_envvar UNINSTALL 'for install, return with empty.'
[ $UNINSTALL ] REMOVE_EXISTING=Y
maybe_ask_preset_envvar REMOVE_EXISTING 'y/Y (yes) or n/N (no)'

## Installation
# misc
bash configure/init.sh
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
bash install/lazyvim.sh
