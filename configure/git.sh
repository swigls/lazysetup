source ~/.bashrc
source libsetup.sh || exit 1

git_config_global pull.rebase false

[[ ! $UNINSTALL ]] && email=$(decrypt data/git/global_user.email)
git_config_global user.email "$email"

[[ ! $UNINSTALL ]] && name=$(decrypt data/git/global_user.name)
git_config_global user.name "$name"

git_remote_set_url
