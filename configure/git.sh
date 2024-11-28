source ~/.bashrc
source fn.sh || exit 1

password_check

git config --global pull.rebase false

email=$(decrypt $(datadir)/git/global_user.email)
git config --global user.email "$email"

name=$(decrypt $(datadir)/git/global_user.name)
git config --global user.name "$name"

git remote set-url origin "git@github.com:swigls/lazysetup"
