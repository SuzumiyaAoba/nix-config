require("config.lazy")
-- require("config.lsp")

vim.opt.clipboard = "unnamedplus"

vim.g.neovide_opacity = 0.95

-- タブ
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.opt.number = true

-- フォント
vim.o.guifont = "Cascadia Next JP:h14"

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- バッファ名取得
    local bufname = vim.api.nvim_buf_get_name(0)
    -- 無名バッファなどは何もしない
    if bufname == "" then
      return
    end

    -- フルパスのディレクトリ名に変換
    local dir = vim.fn.fnamemodify(bufname, ":p:h")

    -- ディレクトリが実在するときだけ lcd する
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd("lcd " .. vim.fn.fnameescape(dir))
      -- あるいは: vim.cmd.lcd(vim.fn.fnameescape(dir))
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local dir = vim.fn.expand("%:p")
    if dir ~= "" then
      vim.cmd("lcd " .. dir)
    end
  end,
})

-- Emacs-like
vim.keymap.set('!', '<M-.>', 'gd')
vim.keymap.set('!', '<M-,>', '<C-o>')

-- fold
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
