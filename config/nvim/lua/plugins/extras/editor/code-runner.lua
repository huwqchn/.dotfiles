return {
  {
    "CRAG666/code_runner.nvim",
    opts = {
      mode = "term",
      focus = false,
      startinsert = false,
      term = {
        position = "horizontal",
        size = 12,
      },
      float = {
        close_key = "<ESC>",
        -- Floating window border (see ':h nvim_open_win')
        border = "rounded",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Floating Window Transparency (see ':h winblend')
        blend = 0,
      },
      before_run_filetype = function()
        vim.cmd(":w")
      end,
      -- put here the commands by filetype
      filetype = {
        c = {
          "cd $dir &&",
          "gcc $fileName",
          "-o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt &&",
          "./$fileNameWithoutExt",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt",
        },
        go = "go run $fileName",
        sh = "bash",
      },
    },
    keys = {
      { "<leader>rr", "<cmd>RunCode<CR>", noremap = true, silent = false, desc = "Run code" },
      { "<leader>rf", "<cmd>RunFile<CR>", noremap = true, silent = false, desc = "Run file" },
      { "<leader>rt", "<cmd>RunFile tab<CR>", noremap = true, silent = false, desc = "Run file on tab" },
      { "<leader>rp", "<cmd>RunProject<CR>", noremap = true, silent = false, desc = "Run project" },
      { "<leader>rx", "<cmd>RunClose<CR>", noremap = true, silent = false, desc = "Close runner" },
      { "<leader>r/", "<cmd>CRFiletype<CR>", noremap = true, silent = false, desc = "Open json with supported file" },
      {
        "<leader>rP",
        "<cmd>CRProjects<CR>",
        noremap = true,
        silent = false,
        desc = "Open json with list of projects",
      },
      {
        "<leader>rF",
        "<cmd>CRFiletype<CR>",
        noremap = true,
        silent = false,
        desc = "Open json with list of filetypes",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = "n",
          { "<leader>r", group = "run" },
        },
      },
    },
  },
  -- {
  --   "folke/edgy.nvim",
  --   optional = true,
  --   opts = {
  --     right = {
  --       {
  --         title = "Runner",
  --         ft = "crunner_*",
  --         size = { width = 0.4 },
  --         -- exclude floating windows
  --         filter = function(buf, win)
  --           return vim.api.nvim_win_get_config(win).relative == ""
  --         end,
  --       },
  --     },
  --   },
  -- },
}
