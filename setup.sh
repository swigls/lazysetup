source fn.sh || exit 1

password_check
uninstall_check GLOBAL

## Installation
# init
bash configure/init.sh
[[ $(is_uninstall) ]] && rm -rf $(installdir) && exit 0

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
bash install/lazyvim.sh
