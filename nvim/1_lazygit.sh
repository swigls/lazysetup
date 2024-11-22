LAZYGIT_DIR=~/.bin
LAZYGIT_PATH=$LAZYGIT_DIR/lazygit
if [ -e $LAZYGIT_PATH ]; then
  if [ -z $remove_existing ]; then
    read -p "lazygit already exists. Remove to Proceed? (y/n)" remove_existing
  fi
  case $remove_existing in
  [yY])
    echo "Removing ${LAZYGIT_PATH}..."
    rm -rf ${LAZYGIT_PATH}
    ;;
  [nN]) exit 0 ;;
  *) echo "Invalid response"; exit 0 ;;
  esac
fi

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
mkdir -p $LAZYGIT_DIR
install lazygit -D -t $LAZYGIT_DIR
rm -f lazygit.tar.gz lazygit

BASH_LAZYGIT="PATH=\$PATH:$LAZYGIT_DIR"
BASHRC=~/.bashrc
if [[ $(cat $BASHRC) == *"$BASH_LAZYGIT"* ]]; then
  echo "Skip: $BASHRC already contains \"$BASH_LAZYGIT\""
else
  echo $BASH_LAZYGIT >>$BASHRC
  source $BASHRC
fi
