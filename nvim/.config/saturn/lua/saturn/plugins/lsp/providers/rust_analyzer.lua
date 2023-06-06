return {
  cargo = {
    features = "all",
  },
  lens = {
    enable = true,
  },
  checkOnSave = {
    enable = true,
    command = "clippy",
  },

  procMacro = {
    enable = true,
  },
}
