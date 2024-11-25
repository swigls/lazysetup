source fn.sh || exit 1

password_check
maybe_ask_preset_envvar remove_existing

# Installation
mkdir -p ~/.bin
cp bin/* ~/.bin/
rc_append ~/.bashrc "PATH=~/.bin:\$PATH"

bash install/git.sh

source source.sh
bash configure/*.sh

bash install/miniconda.sh
bash install/nvim.sh
bash install/lazygit.sh
bash install/ripgrep.sh
bash install/fd.sh
bash install/lazyvim.sh


