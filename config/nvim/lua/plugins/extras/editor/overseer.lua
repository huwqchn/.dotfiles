return {
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    keys = {
      { "<F6>", "<cmd>CompilerOpen<CR>", mode = "n" },
      { "<S-F6>", "<cmd>CompilerToggleResults<CR>", mode = "n" },
    },
    dependencies = { "stevearc/overseer.nvim" },
    config = function(_, opts)
      require("compiler").setup(opts)
    end,
  },
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    cmd = {
      "Grep",
      "OverseerDebugParser",
      "OverseerInfo",
      "OverseerOpen",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerToggle",
      "OverseerRestartLast",
      "CompilerOpen",
      "CompilerToggleResults",
    },
    keys = {
      { "<leader>oo", "<cmd>OverseerToggle<CR>", mode = "n", desc = "Toggle" },
      { "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "Run" },
      { "<leader>oc", "<cmd>OverseerRunCmd<CR>", mode = "n", desc = "Run cmd" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<CR>", mode = "n", desc = "Load bundle" },
      { "<leader>ob", "<cmd>OverseerToggle! bottom<CR>", mode = "n", desc = "Toggle bottom" },
      { "<leader>od", "<cmd>OverseerQuickAction<CR>", mode = "n", desc = "Quick action" },
      { "<leader>os", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "Task action" },
      { "<leader>oR", "<cmd>OverseerRestartLast<CR>", mode = "n", desc = "Restart last" },
    },
    opts = {
      templates = { "builtin", "cpp_build" },
      strategy = { "jobstart" },
      dap = false,
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd("OverseerClose")
          end,
          ["<C-h>"] = "Edit",
          ["<C-n>"] = "IncreaseDetails",
          ["<C-o>"] = "DecreaseDetails",
          ["N"] = "IncreaseAllDetail",
          ["O"] = "DecreaseAllDetail",
          ["{"] = "DecreaseWidth",
          ["}"] = "IncreaseWidth",
          ["["] = "PrevTask",
          ["]"] = "NextTask",
          ["<C-i>"] = "ScrollOutputUp",
          ["<C-e>"] = "ScrollOutputDown",
        },
      },
      log = {
        {
          type = "echo",
          level = vim.log.levels.WARN,
        },
        {
          type = "file",
          filename = "overseer.log",
          level = vim.log.levels.DEBUG,
        },
      },
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          { "on_complete_notify", system = "unfocused" },
          "on_complete_dispose",
        },
        default_neotest = {
          "unique",
          { "on_complete_notify", system = "unfocused", on_change = true },
          "default",
        },
      },
      post_setup = {},
    },
    config = function(_, opts)
      -- opts.templates = vim.tbl_keys(opts.templates)
      local overseer = require("overseer")
      overseer.setup(opts)
      for _, cb in pairs(opts.post_setup) do
        cb()
      end
      vim.api.nvim_create_user_command("OverseerDebugParser", 'lua require("overseer").debug_parser()', {})
      vim.api.nvim_create_user_command("Grep", function(params)
        local args = vim.fn.expandcmd(params.args)
        -- Insert args at the '$*' in the grepprg
        local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
        if num_subs == 0 then
          cmd = cmd .. " " .. args
        end
        local cwd = vim.loop.cwd()
        local task = overseer.new_task({
          cmd = cmd,
          cwd = cwd,
          name = "grep " .. args,
          components = {
            {
              "on_output_quickfix",
              errorformat = vim.o.grepformat,
              open = not params.bang,
              open_height = 8,
              items_only = true,
            },
            -- We don't care to keep this around as long as most tasks
            { "on_complete_dispose", timeout = 30 },
            "default",
          },
        })
        task:start()
      end, { nargs = "*", bang = true, bar = true, complete = "file" })

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  },
}
