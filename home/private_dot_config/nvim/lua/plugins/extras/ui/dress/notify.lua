return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<bs>",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      background_colour = "#000000",
    },
  },
}
