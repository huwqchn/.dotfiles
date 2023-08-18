return {
  {
    "echasnovski/mini.operators",
    event = "BufRead",
    keys = {
      { "<M-t>", "sthww.", desc = "transform word after", remap = true },
      { "<M-S-t>", "sthwW.", desc = "transform word before", remap = true },
    },
    opts = {
      exchange = {
        prefix = "st",
      },
      replace = {
        prefix = "sc",
      },
    },
  },
}
