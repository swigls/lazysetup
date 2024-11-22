NVIM_TAR_LINK=https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
NVIM_DIR=~/.nvim

wget $NVIM_TAR_LINK
tar xzvf nvim-linux64.tar.gz
rm -f nvim-linux64.tar.gz*

if [ -e $NVIM_DIR ]; then
  if [ -z $remove_existing ]; then
    read -p "nvim already exists. Remove to Proceed? (y/n)" remove_existing
  fi
  case $remove_existing in
    [yY] )
      echo "Removing ${NVIM_DIR}...";
      rm -rf ${NVIM_DIR};
      rm -rf $NVIM_DIR/nvim-linux64 ;;
    [nN] ) exit 0;;
    * ) echo "Invalid response"; exit 0 ;;
  esac
fi
mv nvim-linux64 $NVIM_DIR

BASH_NVIM="PATH=\$PATH:$NVIM_DIR/bin"
BASHRC=~/.bashrc
if [[ $(cat $BASHRC) == *"$BASH_NVIM"* ]]; then
  echo "Skip: $BASHRC already contains \"$BASH_NVIM\""
else
  echo $BASH_NVIM >> $BASHRC
  source $BASHRC
fi
