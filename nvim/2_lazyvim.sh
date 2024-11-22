CONFIG=~/.config/nvim

if [ -e $CONFIG ]; then
  if [ -z $remove_existing ]; then
    read -p "nvim config already exists. Remove to install LazyVim? (y/n)" remove_existing
  fi
  case $remove_existing in
  [yY])
    echo "Removing $CONFIG..."
    rm -rf $CONFIG
    LOCAL_SHARE=~/.local/share/nvim
    LOCAL_STATE=~/.local/state/nvim
    CACHE=~/.cache/nvim
    echo "Removing $LOCAL_SHARE, $LOCAL_STATE, $CACHE..."
    rm -rf $LOCAL_SHARE
    rm -rf $LOCAL_STATE
    rm -rf $CACHE;;
  [nN]) exit 0 ;;
  *) echo "Invalid response"; exit 0 ;;
  esac
fi

git clone https://github.com/LazyVim/starter $CONFIG
rm -rf $CONFIG/.git

nvim

# Post Install
#   Recommended to execute `:LazyHealth`
