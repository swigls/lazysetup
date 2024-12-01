source ~/.bashrc
source fn.sh || exit 1

password_check

git_config_global pull.rebase false

email=$(decrypt $(datadir)/git/global_user.email)
git_config_global user.email $email

name=$(decrypt $(datadir)/git/global_user.name)
git_config_global user.name $name

git_remote_set_url
