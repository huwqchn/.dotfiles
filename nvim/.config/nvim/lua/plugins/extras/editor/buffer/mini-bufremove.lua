return {
  {
    "echasnovski/mini.bufremove",
    keys = function(_, keys)
      table.insert(keys, { "<c-w>", "<leader>bd", desc = "Close Buffer", remap = true })
    end,
  },
}
