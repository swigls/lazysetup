source libsetup.sh || exit 1

NVM_DIR="$(lazysetup_config_home)/nvm"
rc_append_line ~/.bashrc "export NVM_DIR=\"$NVM_DIR\""
rc_append_line ~/.bashrc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
rc_append_line ~/.bashrc '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

source ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh |
  PROFILE=/dev/null bash

source ~/.bashrc
nvm install --lts
