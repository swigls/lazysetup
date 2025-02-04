source libsetup.sh || exit 1

# nvm
remove_or_exit $(lazysetup_root)/xdg_base/.config/nvm
rc_append_line $(lazysetup_root)/.bashrc 'export NVM_DIR="'$(lazysetup_root)'/xdg_base/.config/nvm"'
rc_append_line $(lazysetup_root)/.bashrc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'                   # This loads nvm
rc_append_line $(lazysetup_root)/.bashrc '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' # This loads nvm bash_completion

source $(lazysetup_root)/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh |
  PROFILE=/dev/null bash

# node & npm
source $(lazysetup_root)/.bashrc
nvm install --lts
