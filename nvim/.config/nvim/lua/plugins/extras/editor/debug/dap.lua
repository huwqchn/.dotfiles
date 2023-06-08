return {
  {
    "mfussenegger/nvim-dap",
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "<leader>dj" then
          key[1] = "<leader>de"
        elseif key[1] == "<leader>dk" then
          key[1] = "<leader>di"
        elseif key[1] == "<leader>di" then
          key[1] = "<leader>dI"
        elseif key[1] == "<leader>db" then
          key[1] = "<leader>dd"
        elseif key[1] == "<leader>dB" then
          key[1] = "<leader>dD"
        end
      end
      keys = vim.tbl_extend("force", keys, {
        {
          "<leader>db",
          function()
            require("dap").step_back()
          end,
          desc = "Step back",
        },
        { "<F7>", "<leader>dI", desc = "Step Into", remap = true },
        { "<S-F7>", "<leader>do", desc = "Step Out", remap = true },
        { "<F8>", "<leader>dO", desc = "Step Over", remap = true },
        { "<S-F8>", "<leader>db", desc = "Step Back", remap = true },
        { "<F9>", "<leader>dC", desc = "Run to Cursor", remap = true },
        { "<F10>", "<leader>dc", desc = "Continue", remap = true },
      })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "<leader>de" then
          key[1] = "<leader>dE"
        end
      end
    end,
  },
}
