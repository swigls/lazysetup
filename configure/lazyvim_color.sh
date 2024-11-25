source fn.sh || exit 1

maybe_remove ~/.config/nvim/lua/colorscheme.lua

cp data/lazyvim/colorscheme.lua ~/.config/nvim/lua/plugins/
