source ~/.bashrc
source libsetup.sh || exit 1

git config --global --unset-all diff.external 2>/dev/null || true
git config --global --unset-all core.pager 2>/dev/null || true
git config --global --unset-all interactive.diffFilter 2>/dev/null || true

git_config_global pull.rebase false
git_config_global user.email "swigls1@gmail.com"
git_config_global user.name "Hyeonseung Lee"

git_config_global diff.tool critique
git_config_global difftool.prompt false
git_config_global difftool.critique.cmd 'critique difftool "$LOCAL" "$REMOTE"'

git_remote_set_url
