return {
  {
    "folke/flash.nvim",
    optional = true,
    event = "VeryLazy",
    -- event = function()
    --   return {}
    -- end,
    opts = {
      labels = "arstgmneioqwfpbjluyxcdvzkh",
      char = {
        keys = { "f", "F", "t", "T", ";", ":" },
      },
    },
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "s" then
          key[1] = "gj"
        end
      end
      for _, key in ipairs({ "f", "F", "t", "T", ";", ":" }) do
        table.insert(keys, key)
      end
      table.insert(keys, {
        "gJ",
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
      table.insert(keys, {
        "j",
        function()
          require("flash").jump({
            search = { forward = true, wrap = false, multi_window = false },
          })
        end,
        mode = { "n", "x" },
        desc = "jump forward",
      })
      --HACK: This is a hack, because LazyVim keymap bugs
      table.insert(keys, {
        "j",
        function()
          require("flash").jump({
            search = { forward = true, wrap = false, multi_window = false },
          })
        end,
        mode = { "o" },
        desc = "jump forward",
      })
      table.insert(keys, {
        "J",
        function()
          require("flash").jump({
            search = { forward = false, wrap = false, multi_window = false },
          })
        end,
        mode = { "n", "o", "x" },
        desc = "jump previous",
      })
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    enable = false,
  },
}
