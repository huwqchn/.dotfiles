return {
  {
    "echasnovski/mini.bracketed",
    version = false,
    event = "BufReadPost",
    -- keys = {
    --   { "[", mode = { "n", "x", "o" } },
    --   { "]", mode = { "n", "x", "o" } },
    -- },
    opts = {
      buffer = { suffix = "b", options = {} },
      comment = { suffix = "c", options = {} },
      conflict = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file = { suffix = "", options = {} },
      indent = { suffix = "i", options = {} },
      jump = { suffix = "j", options = {} },
      location = { suffix = "a", options = {} },
      oldfile = { suffix = "o", options = {} },
      quickfix = { suffix = "", options = {} },
      treesitter = { suffix = "n", options = {} },
      undo = { suffix = "u", options = {} },
      window = { suffix = "", options = {} },
      yank = { suffix = "y", options = {} },
    },
    config = function(_, opts)
      local bracketed = require("mini.bracketed")
      local function put(cmd, regtype)
        local body = vim.fn.getreg(vim.v.register)
        local type = vim.fn.getregtype(vim.v.register)
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.setreg(vim.v.register, body, regtype or "l")
        bracketed.register_put_region()
        vim.cmd(('normal! "%s%s'):format(vim.v.register, cmd:lower()))
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.setreg(vim.v.register, body, type)
      end

      for _, cmd in ipairs({ "]p", "[p" }) do
        vim.keymap.set("n", cmd, function()
          put(cmd)
        end)
      end
      for _, cmd in ipairs({ "]P", "[P" }) do
        vim.keymap.set("n", cmd, function()
          put(cmd, "c")
        end)
      end

      local put_keys = { "p", "P" }
      for _, lhs in ipairs(put_keys) do
        vim.keymap.set({ "n", "x" }, lhs, function()
          return bracketed.register_put_region(lhs)
        end, { expr = true })
      end
      bracketed.setup(opts)
    end,
  },
}
