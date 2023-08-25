return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>i"] = { name = "+Cscope" },
      },
    },
  },
  {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>is",
        function()
          require("cscope_maps").cscope_prompt("s", vim.fn.expand("<cword>"))
        end,
        desc = "Find this symbol",
      },
      {
        "<leader>ig",
        function()
          require("cscope_maps").cscope_prompt("g", vim.fn.expand("<cword>"))
        end,
        desc = "Find this global defination",
      },
      {
        "<leader>ic",
        function()
          require("cscope_maps").cscope_prompt("c", vim.fn.expand("<cword>"))
        end,
        desc = "Find functions calling this function",
      },
      {
        "<leader>it",
        function()
          require("cscope_maps").cscope_prompt("t", vim.fn.expand("<cword>"))
        end,
        desc = "Find this text string",
      },
      {
        "<leader>ie",
        function()
          require("cscope_maps").cscope_prompt("e", vim.fn.expand("<cword>"))
        end,
        desc = "Find this egrep string",
      },
      {
        "<leader>if",
        function()
          require("cscope_maps").cscope_prompt("f", vim.fn.expand("<cfile>"))
        end,
        desc = "Find this file",
      },
      {
        "<leader>ii",
        function()
          require("cscope_maps").cscope_prompt("i", vim.fn.expand("<cfile>"))
        end,
        desc = "Find file #including this file",
      },
      {
        "<leader>id",
        function()
          require("cscope_maps").cscope_prompt("d", vim.fn.expand("<cword>"))
        end,
        desc = "Find functions called by this function",
      },
      {
        "<leader>ia",
        function()
          require("cscope_maps").cscope_prompt("a", vim.fn.expand("<cword>"))
        end,
        desc = "Find places where this symbol is assigned a value",
      },
      {
        "<leader>ib",
        "<cmd>Cscope build<cr>",
        desc = "Build database",
      },
      {
        "<C-]>",
        "<cmd>exe 'Cstag' expand('<cword>')<cr>",
        desc = "ctag",
      },
    },
    opts = {
      -- maps related defaults
      disable_maps = true, -- "true" disables default keymaps
      skip_input_prompt = false, -- "true" doesn't ask for input

      -- cscope related defaults
      cscope = {
        -- location of cscope db file
        db_file = require("util").find_project_root() .. "/cscope.out",
        -- cscope executable
        exec = "gtags-cscope", -- "cscope" or "gtags-cscope"
        -- choose your fav picker
        picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
        -- "true" does not open picker for single result, just JUMP
        skip_picker_for_single_result = false, -- "false" or "true"
        -- these args are directly passed to "cscope -f <db_file> <args>"
        db_build_cmd_args = { "-bqkv" },
        -- statusline indicator, default is cscope executable
        statusline_indicator = nil,
      },
    },
  },
}
