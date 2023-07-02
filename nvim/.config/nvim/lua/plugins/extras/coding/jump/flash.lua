return {
  {
    "folke/flash.nvim",
    optional = true,
    event = function()
      return {}
    end,
    opts = {
      labels = "arstgmneioqwfpbjluyxcdvzkh",
      modes = {
        char = {
          keys = { "f", "F", "t", "T", ";", [","] = ":" },
        },
      },
    },
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "s" then
          -- key.mode = { "o", "x" }
          -- local key2 = vim.deepcopy(key)
          -- key2[1] = "ss"
          -- key2.mode = "n"
          -- table.insert(keys, key2)
          key[1] = ","
        end
      end
      for _, key in ipairs({ "f", "F", "t", "T", ";", ":" }) do
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
