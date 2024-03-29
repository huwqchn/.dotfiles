return {
  {
    "folke/flash.nvim",
    optional = true,
    event = function()
      return {}
    end,
    opts = {
      search = { enabled = false },
      labels = "arstgmneioqwfpbjluyxcdvzkh",
      modes = {
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
          },
        },
        char = {
          keys = { "f", "F", "t", "T", ";", "," },
        },
      },
    },
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "s" then
          key[1] = "<cr>"
        elseif key[1] == "S" then
          key[1] = "<S-cr>"
        elseif key[1] == "R" then
          table.insert(key.mode, "n")
        end
      end
      for _, key in ipairs({ "f", "F", "t", "T", ";", ":", "/", "?" }) do
        table.insert(keys, key)
      end
      table.insert(keys, {
        "g,",
        function()
          local Flash = require("flash")
          Flash.jump({
            search = { mode = "search" },
            label = { after = false, before = { 0, 0 }, uppercase = false },
            pattern = [[\<\|\>]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                label = { distance = false },
                highlight = { matches = false },
                matcher = function(win)
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label = labels[math.floor((m - 1) / #labels) + 1]
              end
            end,
          })
        end,
        mode = { "n", "o", "x" },
        desc = "2-char jump",
      })
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    enabled = false,
  },
}
