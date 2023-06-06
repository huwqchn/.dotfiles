local M = {}
local ls = require("luasnip")
local ts_utils = require("nvim-treesitter.ts_utils")
local augroup = vim.api.nvim_create_augroup("Custom Luasnip", { clear = true })

local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

function M.create_snippet(opts)
  local snippet = ls.s(opts.trigger, opts.nodes, opts.opts)

  if opts.keymaps then
    for _, keymap in ipairs(opts.keymaps) do
      if not opts.pattern or not opts.keymaps then
        return
      end

      if type(keymap) == "string" then
        keymap = { { "i", "s" }, keymap }
      end

      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = opts.pattern,
        group = augroup,
        callback = function()
          local _, error = pcall(vim.api.nvim_buf_get_var, 0, "luasnipI")

          if error then
            vim.api.nvim_buf_set_var(0, "luasnip1", true)

            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
              LAST_TRIGGERED_SNIPPET = snippet
            end, { silent = true, buffer = true })
          end

          -- if not vim.tbl_contains(USER_MAPPINGS, keymap[2]) then
          --     table.insert(USER_MAPPINGS, keymap[2])
          -- end
        end,
      })
    end
  end

  table.insert(opts.target_table, snippet)
end

function M.get_top_node()
  local node = ts_utils.get_node_at_cursor()
  local root = ts_utils.get_root_for_node(node)
  local parent = node:parent()

  while parent ~= nil and parent ~= root do
    node = parent
    parent = node:parent()
  end
  return node
end

local function filter_str_len_larger_than(tbl, str_len)
  local return_tbl = {}
  for _, v in ipairs(tbl) do
    if #v > str_len then
      table.insert(return_tbl, v)
    end
  end
  return return_tbl
end

local function filter_unique(tbl)
  local hashmap, return_tbl = {}, {}
  for _, v in ipairs(tbl) do
    if not hashmap[v] then
      hashmap[v] = i
      table.insert(return_tbl, v)
    end
  end

  return return_tbl
end

local function get_root_node(buf_nr, lang)
  local parser = vim.treesitter.get_parser(buf_nr, lang)
  local trees = parser:parse()
  return trees[1]:root()
end

local function get_nodes_text_tbl(opts)
  -- local top_node = M.get_top_node()
  local query = opts.query
  local node_text_tbl = {}

  local root = get_root_node(0, opts.lang)

  for _, matches, _ in query:iter_matches(root, 0) do
    for id, node in pairs(matches) do
      local curr_capture_name = query.captures[id]
      if opts.capture_name == curr_capture_name then
        local node_text = vim.treesitter.query.get_node_text(node, 0)
        table.insert(node_text_tbl, node_text)
      end
    end
  end

  return node_text_tbl
end

-------------------------------------------- Query From File -------------

local function sized_table(value)
  return type(value) == "table" and next(value) ~= nil
end

local function get_query_from_file(lang, query_name)
  local _, query = pcall(vim.treesitter.get_query, lang, query_name)
  if sized_table(query) then
    return query
  end
end

M.tsn = function(jump_index, opts)
  opts = opts or {}
  if opts.lang and opts.query_file then
    opts.query = get_query_from_file(opts.lang, opts.query_file)
  end

  return d(jump_index, function()
    local node_text_tbl = get_nodes_text_tbl(opts)
    if #node_text_tbl > 0 then
      local filtered_node_text_tbl = filter_unique(node_text_tbl)
      filtered_node_text_tbl = filter_str_len_larger_than(node_text_tbl, 1)

      local choices_tbl = {}
      for _, v in ipairs(filtered_node_text_tbl) do
        print(v)
        table.insert(choices_tbl, i(1, v))
      end

      return sn(nil, {
        c(1, choices_tbl),
      })
    else
      return sn(nil, {
        t(""),
      })
    end
  end, {})
end

return M
