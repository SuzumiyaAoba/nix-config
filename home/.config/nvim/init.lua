require("config.lazy")

vim.opt.clipboard = "unnamedplus"

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.opt.number = true

vim.o.guifont = "Cascadia Next JP:h14"

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)

    if file ~= "" then
      local dir = vim.fn.fnamemodify(file, ":p:h")
      vim.cmd("lcd " .. dir)
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern	= "netrw",
  callback = function()
    local dir = vim.fn.expand("%:p")
    if dir ~= "" then
      vim.cmd("lcd " .. dir)
    end
  end,
})
