source libsetup.sh || exit 1

NVM_DIR="$HOME/.nvm"
rc_append_line ~/.bashrc "export NVM_DIR=\"$NVM_DIR\""
rc_append_line ~/.bashrc '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
# rc_append_line ~/.bashrc '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh |
  PROFILE=/dev/null bash

export NVM_DIR=$HOME/.nvm
[ -s $NVM_DIR/nvm.sh ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
