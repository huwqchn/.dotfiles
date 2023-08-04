return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = { theme = "light" },
  },
  {
    "kiran94/maim.nvim",
    config = true,
    cmd = { "Maim", "MaimMarkdown" },
  },
}
