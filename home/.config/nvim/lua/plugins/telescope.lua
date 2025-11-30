return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install',
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        file_ignore_patterns = {
          "node_modules",
          ".git",
        },
      },
    },
    keys = function()
      local builtin = require("telescope.builtin")

      -- .git を探してプロジェクトルートを返す
      local function project_root()
        local git_dir = vim.fs.find(".git", {
          upward = true,
          type = "directory",
        })[1]

        if git_dir then
          return vim.fs.dirname(git_dir)
        end
        return vim.loop.cwd()
      end
      return {
        {
          "<leader>pf",
          function()
            builtin.find_files({
              cwd = project_root(),
            })
          end,
          desc = "Find Files (git root)",
        },
        {
          "<leader>pg",
          function()
            builtin.live_grep({
              cwd = project_root(),
            })
          end,
          desc = "Live Grep (git root)"
        },
        {
          "<leader>ff",
          function()
            builtin.find_files({ no_ignore = false, hidden = true })
          end,
          desc = "Find Files",
        }
      }
    end,
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      require('telescope').load_extension('fzf')
    end,
  },
}
