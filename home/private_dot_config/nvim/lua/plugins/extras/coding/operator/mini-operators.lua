return {
  {
    "echasnovski/mini.operators",
    event = "BufRead",
    keys = {
      { "<M-t>", "sxhww.", desc = "transpose word after", remap = true, silent = true },
      { "<M-S-t>", "sxhwb.", desc = "transpose word before", remap = true, silent = true },
      { "<M-m>", "gmm", desc = "multiply line", remap = true, silent = true },
      { "<M-r>", "schw", desc = "replace word", remap = true, silent = true },
    },
    opts = {
      exchange = {
        prefix = "sx",
      },
      replace = {
        prefix = "sc",
      },
    },
  },
}
