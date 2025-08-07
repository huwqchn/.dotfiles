return {
  { import = "lazyvim.plugins.extras.dap.core" },
  {
    "mfussenegger/nvim-dap",
    keys = {
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
}
