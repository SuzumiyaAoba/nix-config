return {
  {
    "nvim-telescope/telescope-ghq.nvim",
    dependencies = {
      "nvim-nvimtelecope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "ghq"

      vim.keymap.set('n', '<leader>gg', ":Telescope ghq<CR>")
    end,
  }
}
