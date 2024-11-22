ROOTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
function rootdir {
  echo $ROOTDIR
}
function datadir {
  echo $ROOTDIR/data
}
function die {
    printf "Script failed: %s\n\n" "$1"
    exit 1
}
function maybe_ask_preset_envvar {
  envvar=$1
  if [ ${!envvar} ]; then
    return 0
  fi
  read -p "Type in the preset the value of \"$envvar\" (empty for non-preset):" value
  if [ $value ]; then
    export $envvar=$value
  fi
}

# Privacy
function password_check {
  if [ ! $password ]; then
    read -s -p "Type in the password for private keys and repos:" password && echo \n
  fi
  check_result=$(decrypt $(datadir)/password)
  if [[ ! $check_result == correct ]]; then
    echo "Password incorrect."
    exit 1
  fi
  export password=$password
}
function decrypt {
  echo "$(cat $1 | openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:$password)"
}

function maybe_remove {
  file=$1
  if [ -e $file ]; then
    if [ -z $remove_existing ]; then
      read -p "$file already exists. Remove to Proceed? (y/n)" remove_existing
    fi
    case $remove_existing in
      [yY] )
        echo "Removing $file ..."
        rm -rf $file;;
      [nN] ) exit 0;;
      * ) echo "Invalid response"; exit 0 ;;
    esac
  fi
}

function rc_append {
  file=$1
  content=$2
  if [[ $(cat $file) == *"$content"* ]]; then
    echo "Skip: $file already contains \"$content\""
  else
    echo $content >> $file
    source $file
  fi
}
