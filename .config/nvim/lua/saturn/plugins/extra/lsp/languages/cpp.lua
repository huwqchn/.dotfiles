-- set a linter for cpp
-- local linters = require "saturn.plugins.core.lsp.null-ls.linters"
-- linters.setup {
--   { command = "cpplint", filetypes = { "cpp" } }
-- }

-- set a formatter for cpp
local formatters = require "saturn.plugins.core.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang-format", filetypes = { "cpp" } }
}

-- set a lsp for cpp
local manager = require 'saturn.plugins.core.lsp.manager'
manager.setup("clangd", {
  on_init = require("saturn.plugins.core.lsp").common_on_init,
  capabilities = require("saturn.plugins.core.lsp").common_capabilities(),
} )

pcall(function()
  require('nvim-treesitter.configs').setup({
    -- ...
    nt_cpp_tools = {
      enable = true,
      preview = {
        quit = 'q', -- optional keymapping for quit preview
        accept = '<tab>' -- optional keymapping for accept preview
      },
      header_extension = 'h', -- optional
      source_extension = 'cxx', -- optional
      custom_define_class_function_commands = { -- optional
        TSCppImplWrite = {
          output_handle = require'nvim-treesitter.nt-cpp-tools.output_handlers'.get_add_to_cpp()
        }
        --[[
        <your impl function custom command name> = {
          output_handle = function (str, context)
            -- string contains the class implementation
            -- do whatever you want to do with it
          end
        }
        ]]
      }
    }
  })
end)
