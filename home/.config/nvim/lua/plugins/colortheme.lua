return { 
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme tokyonight]])
  --   end
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "latte",
  --     })

  --     vim.cmd.colorscheme "catppuccin"
  --   end,
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "dawn"
  --     })

  --     vim.cmd("colorscheme rose-pine")
  --   end
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "dark"
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  -- },
  -- {
  --   "neanias/everforest-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "light"

  --     require("everforest").setup({
  --     })

  --     vim.cmd([[colorscheme everforest]])
  --   end,
  -- },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      require('onedark').load()
    end
  }
}
