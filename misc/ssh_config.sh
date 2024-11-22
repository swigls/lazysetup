CONFIG=~/.ssh/config
if [ -e $CONFIG ]; then
  if [ -z $remove_existing ]; then
    read -p "ssh config already exists. Remove to Proceed? (y/n)" remove_existing
  fi
  case $remove_existing in
    [yY] )
      echo "Replacing ${CONFIG} and related files...";;
    [nN] ) exit 0;;
    * ) echo "Invalid response"; exit 0 ;;
  esac
fi

echo \
"Host xl8_git
  HostName github.com/xl8-ai
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  AddKeysToAgent yes" > $CONFIG 

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
private_key_encrypted=$(cat ${SCRIPT_DIR}/private_key_encrypted)
private_key=$(cat private_key | openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:$password)
if [[ $private_key == *"bad decrypt"* ]]; then
  echo 1111
fi
#echo $private_key > ~/.ssh/id_ed25519

echo 222
echo \
"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICPyGF5ecJAy9giuXwCb6GQnIFet799zEkLC2aUUOZty swigls1@gmail.com" > ~/.ssh/id_ed25519.pub
