# Path
function installdir {
  echo ~/.lazysetup
}

# Bash utils
function die {
  printf "Script failed: %s\n\n" "$1"
  exit 1
}
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }
function uninstall_check {
  [[ $INSTALL || $UNINSTALL ]] && return 0
  existing_file=$1
  desc="Type in i[install] or u[uninstall] ()('$existing_file' will be uninstalled)"
  read -rp "${desc}: " install_option
  case $install_option in
  [iI] | install | INSTALL)
    export INSTALL=1
    ;;
  [uU] | uninstall | UNINSTALL)
    export UNINSTALL=1
    ;;
  *)
    echo "Invalid response"
    exit 1
    ;;
  esac
}

# Privacy
function password_check {
  [ "$PASSWORD" ] && return 0
  read -rs -p $'Type in the password for private keys and repos: \n' password
  export PASSWORD=$password
  check_result=$(decrypt data/password)
  if [[ ! $check_result == correct ]]; then
    echo "Password incorrect."
    exit 1
  fi
}
function decrypt {
  [ ! "$PASSWORD" ] && password_check
  openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:"$PASSWORD" <"$1"
}

# Git
function git_config_global {
  var=$1
  value=$2
  if [[ $UNINSTALL ]]; then
    git config --global --unset "$var"
  else
    git config --global "$var" "$value"
  fi
}
function git_remote_set_url {
  if [[ $UNINSTALL ]]; then
    git remote set-url origin "https://github.com/swigls/lazysetup"
  else
    git remote set-url origin "git@github.com:swigls/lazysetup"
  fi
}

# Files
function remove_or_exit {
  file=$1
  if [ -e "$file" ]; then
    remove_existing=$REMOVE_EXISTING
    if [ ! "$REMOVE_EXISTING" ]; then
      read -rp "$file already exists. Remove to Proceed? (y/n)" remove_existing
    fi
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
    if [[ $(cat "$file") == *"$content"* ]]; then
      echo "Skip: $file already contains \"$content\""
    else
      echo "$content" >>"$file"
    fi
  fi
}
