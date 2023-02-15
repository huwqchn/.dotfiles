--FIXME: not working yet
--
-- local neorg_callbacks = require("neorg.callbacks")
-- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
--   -- Map all the below keybinds only when the "norg" mode is active
--   keybinds.map_event_to_mode("norg", {
--     n = { -- Bind keys in normal mode
--       { "<leader>sn", "core.integrations.telescope.find_linkable" },
--     },
--
--     i = { -- Bind in insert mode
--       { "<C-l>", "core.integrations.telescope.insert_link" },
--     },
--   }, {
--     silent = true,
--     noremap = true,
--   })
-- end)
--

-- disable colorcolumn
vim.o.colorcolumn = ""
vim.o.wrap = true
