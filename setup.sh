programname=$0
function usage {
    echo ""
    echo "Setup development environments by executing a single script."
    echo ""
    echo "usage: $programname --remove_existing bool"
    echo ""
    echo "  --remove_existing bool  Whether to remove existing files to setup."
    echo "                          (example: y/Y to yes, n/N to no)"
    echo ""
}
function die {
    printf "Script failed: %s\n\n" "$1"
    exit 1
}
while [ $# -gt 0 ]; do
  if [[ $1 == "--help" ]]; then
    usage
    exit 0
  elif [[ $1 == "--"* ]]; then
    v="${1/--/}"
    declare "$v"="$2"
    shift
  fi
  shift
done


#if [[ -z $remove_existing ]]; then
#  usage
#  die "Missing parameter --remove_existing"
#fi

read -s -p "Type in the password for private keys and repos:" password
password_check=$(cat password_encrypted | openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:${password})
if [[ ! $password_check == correct ]]; then
  echo "Password incorrect."
  exit 1
fi
export password=$password

if [ $remove_existing ]; then
  case $remove_existing in
  [yYnN])
    echo "Proceed setup with remove_existing=$remove_existing"
    export remove_existing=$remove_existing
    ;;
  *)
    echo "Invalid \$remove_existing value. It should be one among y/Y/n/N."
    exit 1
    ;;
  esac
else
  export remove_existing=
fi

bash misc/*.sh

bash nvim/0_nvim.sh
bash nvim/1_lazygit.sh
bash nvim/2_lazyvim.sh

source ~/.bashrc
source ~/.inputrc
source ~/.vimrc
