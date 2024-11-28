source fn.sh || exit 1

remove_or_exit ~/.config/nvim/lua/colorscheme.lua

cp data/lazyvim/colorscheme.lua ~/.config/nvim/lua/plugins/
