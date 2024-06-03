return {
  -- better increase/descrease
  { import = "lazyvim.plugins.extras.editor.dial" },
  {
    "monaqa/dial.nvim",
    optional = true,
    -- stylua: ignore
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "<C-a>" then
          key[1] = "<C-=>"
        elseif key[1] == "<C-x>" then
          key[1] = "<C-->"
        elseif key[1] == "g<C-a>" then
          key[1] = "g<C-=>"
        else
          key[1] = "g<C-->"
        end
      end
    end,
  },
}
