require("config.lazy")

-- OS のクリップボードと連携
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- タブ
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- 行番号
vim.opt.number = true

-- フォント
vim.o.guifont = "Cascadia Next JP:h14"

-- エンコーディング
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "ucs-bom", "utf-8", "euc-jp", "cp932" }

-- カーソル
vim.opt.cursorline = true
vim.opt.virtualedit = "onemore"

-- 視覚ベル
vim.opt.visualbell = true

-- 括弧
vim.opt.showmatch = true

-- コマンドライン補完
vim.opt.wildmode = { "list", "longest" }
