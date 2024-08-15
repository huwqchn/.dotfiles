return {
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dj", false },
      { "<leader>dk", false },
      { "<leader>dB", false },

      {
        "<leader>db",
        function()
          require("dap").step_back()
        end,
        desc = "Step back",
      },
      {
        "<leader>de",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>di",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },

      {
        "<leader>dI",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dd",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dD",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      -- jetbrains-like debug keymaps
      { "<F7>", "<leader>dI", desc = "Step Into", remap = true },
      { "<S-F7>", "<leader>do", desc = "Step Out", remap = true },
      { "<F8>", "<leader>dO", desc = "Step Over", remap = true },
      { "<S-F8>", "<leader>db", desc = "Step Back", remap = true },
      { "<F9>", "<leader>dC", desc = "Run to Cursor", remap = true },
      { "<F10>", "<leader>dc", desc = "Continue", remap = true },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      { "<leader>de", false, mode = { "n", "v" } },
      {
        "<leader>dE",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
  },
}
