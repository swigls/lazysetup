return {
  -- add gruvbox
  { "sainnhe/gruvbox-material" },
  { "projekt0n/github-nvim-theme" },
  { "folke/tokyonight.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
     lazy = false,
     priority = 1000,
     config = function()
       -- Optionally configure and load the colorscheme
       -- directly inside the plugin declaration.
       vim.g.gruvbox_material_enable_italic = true
       vim.cmd.colorscheme('gruvbox-material')
     end
  }
}
