return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
  },
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   config = function()
  --     require('lspsaga').setup({})
  --   end,
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter', -- optional
  --     'nvim-tree/nvim-web-devicons',     -- optional
  --   }
  -- },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        function()
          -- nvim-tree を左に開く
          vim.cmd("NvimTreeOpen")

          -- nvim-tree ウィンドウへフォーカス
          local tree_win = require("nvim-tree.view").get_winnr()
          if tree_win then vim.api.nvim_set_current_win(tree_win) end

          -- その下に trouble.symbols を開く
          require("trouble").toggle("symbols", {
            win = { position = "bottom" },
          })
        end,
        desc = "Symbols below nvim-tree",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
}
