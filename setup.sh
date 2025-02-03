#!/bin/bash

# init
bash configure/init.sh

# misc
bash configure/no_beep.sh
bash configure/tmux.sh
bash configure/ssh.sh
bash install/exe.sh

# git
bash install/git.sh
bash configure/git.sh

# conda
bash install/conda.sh

# requirements for lazyvim
bash install/nvim.sh
bash install/lazygit.sh
bash install/ripgrep.sh
bash install/fd.sh
bash install/npm.sh

# lazyvim
bash install/lazyvim.sh
bash configure/lazyvim.sh
