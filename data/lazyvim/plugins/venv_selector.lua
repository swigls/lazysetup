return {
	"linux-cultist/venv-selector.nvim",
	opts = {
		settings = {
			search = {
				anaconda_envs = {
					command = "fd bin/python$ ~/.lazysetup/conda/envs --full-path --color never -E /proc", -- change path here to your anaconda envs
				},
				-- anaconda_base = {
				-- 	command = "fd /python$ ~/.lazysetup/conda --full-path --color never -E /proc", -- change path here to your anaconda base
				-- },
			},
			options = {
				notify_user_on_venv_activation = false,
				search_workspace = false,
			},
		},
	},
}
