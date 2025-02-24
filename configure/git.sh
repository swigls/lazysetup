source ~/.bashrc
source libsetup.sh || exit 1

git_config_global pull.rebase false

[[ ! $UNINSTALL ]] && email="swigls1@gmail.com"
git_config_global user.email "$email"

[[ ! $UNINSTALL ]] && name="Hyeonseung Lee"
git_config_global user.name "$name"

git_remote_set_url
