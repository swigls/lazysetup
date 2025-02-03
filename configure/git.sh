source ~/.bashrc
source fn.sh || exit 1

git_config_global pull.rebase false

email=$(decrypt data/git/global_user.email)
git_config_global user.email "$email"

name=$(decrypt data/git/global_user.name)
git_config_global user.name "$name"

git_remote_set_url
