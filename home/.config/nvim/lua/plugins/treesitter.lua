return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- treesitter
      require('nvim-treesitter').install({
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "nix",
        "java",
        "typescript",
        "javascript",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  }
}
