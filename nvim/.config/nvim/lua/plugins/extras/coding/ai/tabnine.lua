return {
  {
    "nvim-cmp",
    dependencies = {
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        opts = {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          ignored_file_types = { -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
          },
          show_prediction_strength = true,
        },
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "cmp_tabnine", group_index = 2 })
    end,
  },
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    event = "InsertEnter",
    cmd = {
      "TabnineToggle",
      "TabnineDisable",
      "TabnineEnable",
      "TabnineToggle",
      "TabnineHub",
    },
    keys = {
      {
        "<leader>at",
        "<cmd>TabnineToggle<CR>",
        desc = "TabNine Toggle",
      },
      {
        "<leader>aC",
        function()
          require("tabnine.chat").open()
        end,
        desc = "Tabnine Chat",
        mode = { "n", "x" },
      },
    },
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<M-a>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local icon = require("lazyvim.config").icons.kinds.TabNine
      table.insert(opts.sections.lualine_x, 2, require("lazyvim.util").lualine.cmp_source("cmp_tabnine", icon))
    end,
  },
}
