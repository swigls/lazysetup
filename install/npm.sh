source libsetup.sh || exit 1

# nvm
remove_or_exit $(installdir)/xdg_base/.config/nvm
rc_append_line $(installdir)/.bashrc 'export NVM_DIR="'$(installdir)'/xdg_base/.config/nvm"'
rc_append_line $(installdir)/.bashrc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'                   # This loads nvm
rc_append_line $(installdir)/.bashrc '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' # This loads nvm bash_completion

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh |
  PROFILE=/dev/null bash

# node & npm
source $(installdir)/.bashrc
nvm install --lts
