return {
  'nvim-tree/nvim-tree.lua',
  depdencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    require('nvim-tree').setup({
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
    })

    vim.keymap.set('n', '<leader>to', ':NvimTreeOpen<CR>')
    vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')
  end,
}
