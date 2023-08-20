return {
  {
    "echasnovski/mini.operators",
    event = "BufRead",
    keys = {
      { "<M-t>", "sxhww.", desc = "transform word after", remap = true },
      { "<M-S-t>", "sxhwb.", desc = "transform word before", remap = true },
      { "<M-m>", "gmm", desc = "multiply line", remap = true },
      { "<M-r>", "schw", desc = "replace word", remap = true },
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
