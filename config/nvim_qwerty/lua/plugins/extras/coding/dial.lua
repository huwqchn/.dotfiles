local key_remap = {
  ["<C-a>"] = "+",
  ["<C-x>"] = "-",
  ["g<C-a>"] = "g+",
  ["g<C-x>"] = "g-",
}

return {
  -- better increase/descrease
  { import = "lazyvim.plugins.extras.editor.dial" },
  {
    "monaqa/dial.nvim",
    optional = true,
    -- stylua: ignore
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        key[1] = key_remap[key[1]]
      end
    end,
  },
}
