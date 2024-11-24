source fn.sh || exit 1

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
