# Path
ROOTDIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
function rootdir {
  echo $ROOTDIR
}
function datadir {
  echo $ROOTDIR/data
}

# Bash utils
function die {
  printf "Script failed: %s\n\n" "$1"
  exit 1
}
function maybe_ask_preset_envvar {
  ENVVAR=$1
  description=$2
  if [ ${!ENVVAR} ]; then
    return 0
  fi
  read -p "Type in the preset the value of \"$ENVVAR\" ($2): " value
  if [ $value ]; then
    export $ENVVAR=$value
  fi
}
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# Private
function password_check {
  password=$PASSWORD
  if [ ! $password ]; then
    read -s -p "Type in the password for private keys and repos:" password && echo \n
  fi
  check_result=$(decrypt $(datadir)/password)
  if [[ ! $check_result == correct ]]; then
    echo "Password incorrect."
    exit 1
  fi
  export PASSWORD=$password
}
function decrypt {
  echo "$(cat $1 | openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:$password)"
}

# Files
function remove_or_exit {
  file=$1
  if [ -e $file ]; then
    remove_existing=$REMOVE_EXISTING
    if [ ! $REMOVE_EXISTING ]; then
      read -p "$file already exists. Remove to Proceed? (y/n)" remove_existing
    fi
    case $remove_existing in
    [yY])
      echo "Removing $file ..."
      rm -rf $file
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
  filename=$(basename $link)
  target_dir=$2
  curl -LO $link
  if [[ $target_dir ]]; then
    mkdir -p $target_dir
    tar xf $filename -C $target_dir/
  else
    tar xf $filename
  fi
  rm -f $filename
}
function rc_append {
  file=$1
  content=$2
  touch $file
  if [[ $(cat $file) == *"$content"* ]]; then
    echo "Skip: $file already contains \"$content\""
  else
    echo "$content" >>$file
  fi
}
