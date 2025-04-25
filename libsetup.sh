source lib.sh || exit 1
# Echo for source
echo "[$0]"

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# Git
function git_config_global {
  make_sure_git_installed
  var=$1
  value=$2
  if [[ $UNINSTALL ]]; then
    git config --global --unset "$var"
  else
    git config --global "$var" "$value"
  fi
}
function git_remote_set_url {
  make_sure_git_installed
  if [[ $UNINSTALL ]]; then
    git remote set-url origin "https://github.com/swigls/lazysetup"
  else
    git remote set-url origin "git@github.com:swigls/lazysetup"
  fi
}
function make_sure_git_installed {
  if ! command -v git >/dev/null 2>&1; then
    lazyinstall_single "install/git.sh"
    lazysourcerc
  fi
}

# Files
function remove_or_exit {
  file=$1
  if [ -e "$file" ]; then
    # read -rp "$file already exists. Remove to Proceed? (y/n)" remove_existing
    remove_existing=n  # TODO: clean code
    case $remove_existing in
    [yY])
      echo "Removing $file ..."
      rm -rf "$file"
      ;;
    [nN]) exit 0 ;;
    *)
      echo "Invalid response"
      exit 1
      ;;
    esac
  fi
}
function curl_tar_and_extract {
  link=$1
  filename=$(basename "$link")
  target_dir=$2
  curl -LO "$link"
  if [[ $target_dir ]]; then
    mkdir -p "$target_dir"
    tar xf "$filename" -C "$target_dir"/
  else
    tar xf "$filename"
  fi
  rm -f "$filename"
}
function rc_append_line {
  file=$1
  content=$2
  filedir=$(dirname "$file")
  mkdir -p "$filedir"
  touch "$file"
  if [[ $UNINSTALL ]]; then
    if [[ $(cat "$file") == *"$content"* ]]; then
      awk -v pattern="$content" '$0 != pattern' "$file" >temp && mv temp "$file"
      echo "Removed \"$content\" from $file"
      return 1
    fi
  else
    if [[ $(cat "$file") != *"$content"* ]]; then
      echo "$content" >>"$file"
    fi
  fi
}
