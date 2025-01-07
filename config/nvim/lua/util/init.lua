local M = {}

-- cowboy
function M.cowboy(mode, key, map)
  local id
  local ok = true
  local count = 0
  local timer = assert(vim.uv.new_timer())
  local eval = function(m)
    if type(m) == "function" then
      return m()
    elseif m == nil then
      return key
    elseif string.match(m, "^v:") then
      local key_to_feed = vim.api.nvim_eval(m)
      -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key_to_feed, true, false, true), "n", false)
      return key_to_feed
    else
      return m
    end
  end
  vim.keymap.set(mode, key, function()
    if vim.v.count > 0 then
      count = 0
    end
    if count >= 10 and vim.bo.buftype ~= "nofile" then
      ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
        icon = "🤠",
        replace = id,
        keep = function()
          return count >= 10
        end,
      })
      if not ok then
        id = nil
        return eval(map)
      end
    else
      count = count + 1
      timer:start(2000, 0, function()
        count = 0
      end)
      return eval(map)
    end
  end, { expr = true, silent = true })
end

return M
