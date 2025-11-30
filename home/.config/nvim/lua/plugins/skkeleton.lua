return {
  {
    "vim-denops/denops.vim",
    lazy = false,
  },
  {
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
    },
    lazy = false,
    config = function()
      -- IME を無効化
      if vim.g.neovide then
        vim.g.neovide_input_ime = false
      end

      local dict_path = vim.fn.expand("~/.cache/skk/SKK-JISYO.L")
      local dict_dir  = vim.fn.fnamemodify(dict_path, ":h")
      local dict_url  = "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L"

      -- 辞書がなければダウンロード
      if vim.fn.filereadable(dict_path) == 0 then
        -- ディレクトリ作成
        vim.fn.mkdir(dict_dir, "p")

        -- curl でダウンロード
        local cmd = {
          "curl",
          "-fL",          -- fail + follow redirect
          "-o", dict_path,
          dict_url,
        }

        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify("SKK-JISYO.L のダウンロードに失敗しました: " .. result, vim.log.levels.ERROR)
        else
          vim.notify("SKK-JISYO.L をダウンロードしました: " .. dict_path, vim.log.levels.INFO)
        end
      end
      vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
      vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)")

      vim.fn["skkeleton#config"]({
        globalDictionaries = {
          { dict_path, "euc-jp" },
        },
      })
    end,
  },
}
