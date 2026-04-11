source ~/.bashrc
source libsetup.sh || exit 1

git_config_global pull.rebase false
git_config_global user.email "swigls1@gmail.com"
git_config_global user.name "Hyeonseung Lee"

git_remote_set_url
