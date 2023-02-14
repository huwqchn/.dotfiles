return {
  {
    "kyazdani42/nvim-tree.lua",
    enabled = false,
  },
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>ee",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("saturn.utils.plugin").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>eE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
          ["e"] = "none",
          ["E"] = "toggle_auto_expand_width",
          ["N"] = {
            "toggle_node",
            nowait = false,
          },
        },
      },
    },
  },
}
