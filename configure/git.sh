source ~/.bashrc
source libsetup.sh || exit 1


if [[ $UNINSTALL ]]; then
  git_config_global pull.rebase ""
  git_config_global user.email ""
  git_config_global user.name ""
  exit 0
fi

git_config_global pull.rebase false

email=$(decrypt data/git/global_user.email)
git_config_global user.email "$email"

name=$(decrypt data/git/global_user.name)
git_config_global user.name "$name"

git_remote_set_url
