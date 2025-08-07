return {
  { import = "lazyvim.plugins.extras.editor.mini-move" },
  {
    "echasnovski/mini.move",
    version = false,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.move")
      local mappings = {
        { opts.mappings.left, mode = "x" },
        { opts.mappings.right, mode = "x" },
        { opts.mappings.down, mode = "x" },
        { opts.mappings.up, mode = "x" },
        { opts.mappings.line_left },
        { opts.mappings.line_right },
        { opts.mappings.line_down },
        { opts.mappings.line_up },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    },
  },
}
