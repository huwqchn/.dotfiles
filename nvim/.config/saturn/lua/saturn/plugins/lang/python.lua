return {
  { "mfussenegger/nvim-dap-python", ft = "python" },
  {
    "nvim-neotest/neotest",
    opts = function()
      local present, neotest_python = pcall(require, "neotest-python")
      if present then
        return {
          adapters = {
            neotest_python({
              dap = {
                justMyCode = false,
                console = "integratedTerminal",
              },
              args = { "--log-level", "DEBUG", "--quiet" },
              runner = "pytest",
            }),
          },
        }
      end
      return {}
    end,
  },
  { "nvim-neotest/neotest-python", ft = "python" },
}
