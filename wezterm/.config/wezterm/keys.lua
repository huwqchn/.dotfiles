local wezterm = require("wezterm")

local act = wezterm.action
local M = {}

M.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
M.mod = "SHIFT|CTRL"
M.smart_split = wezterm.action_callback(function(window, pane)
	local dim = pane:get_dimensions()
	if dim.pixel_height > dim.pixel_width then
		window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	end
end)

M.smart_quit = wezterm.action_callback(function(window, pane)
	if M.is_vim(pane) then
		window:perform_action(act.SendKey({ key = "q", mods = "CTRL" }), pane)
	else
		window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
	end
end)

---@param config Config
function M.setup(config)
	config.disable_default_key_bindings = true
	config.leader = M.leader
	config.keys = {
		{ mods = "LEADER", key = "a", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		-- Scrollback
		{ mods = M.mod, key = "i", action = act.ScrollByPage(-0.5) },
		{ mods = M.mod, key = "e", action = act.ScrollByPage(0.5) },
		{ mods = M.mod, key = "o", action = act({ ActivateTabRelative = 1 }) },
		{ mods = M.mod, key = "n", action = act({ ActivateTabRelative = -1 }) },
		-- New Tab
		{ mods = "LEADER", key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		-- close pane
		{ mods = "CTRL", key = "q", action = M.smart_quit },
		-- Splits
		{ mods = "LEADER", key = "Enter", action = M.smart_split },
		{
			mods = "LEADER",
			key = "n",
			action = act.SplitPane({ direction = "Left", size = { Percent = 50 } }),
		},
		{
			mods = "LEADER",
			key = "e",
			action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
		},
		{
			mods = "LEADER",
			key = "i",
			action = act.SplitPane({ direction = "Up", size = { Percent = 50 } }),
		},
		{
			mods = "LEADER",
			key = "o",
			action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
		},
		-- Move Tabs
		{ mods = "LEADER", key = ">", action = act.MoveTabRelative(1) },
		{ mods = "LEADER", key = "<", action = act.MoveTabRelative(-1) },
		-- Acivate Tabs
		{ mods = "LEADER", key = "]", action = act({ ActivateTabRelative = 1 }) },
		{ mods = "LEADER", key = "[", action = act({ ActivateTabRelative = -1 }) },
		{ mods = "LEADER", key = "r", action = wezterm.action.RotatePanes("Clockwise") },
		-- show the pane selection mode, but have it swap the active and selected panes
		{ mods = "LEADER", key = "s", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
		-- Clipboard
		{ mods = "LEADER", key = "c", action = act.CopyTo("Clipboard") },
		{ mods = "LEADER", key = "Space", action = act.QuickSelect },
		{ mods = "LEADER", key = "x", action = act.ActivateCopyMode },
		{ mods = "LEADER", key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
		{ mods = "LEADER", key = "v", action = act.PasteFrom("Clipboard") },
		{ mods = "LEADER", key = "z", action = act.TogglePaneZoomState },
		{ mods = "LEADER", key = "p", action = act.ActivateCommandPalette },
		{ mods = "LEADER", key = "d", action = act.ShowDebugOverlay },
		-- extended keys
		{ mods = "CTRL", key = "h", action = act.SendString("\x1b[104;5u") },
		{ mods = "CTRL", key = "m", action = act.SendString("\x1b[109;5u") },
		{ mods = "CTRL", key = "i", action = act.SendString("\x1b[105;5u") },
		{ mods = "CTRL", key = "Enter", action = act.SendString("\x1b[105;5u") },
		{ mods = "SHIFT", key = "\r", action = act.SendString("\033[\015;2u") },
	}

	for dir, key in pairs(M.pane_nav) do
		table.insert(config.keys, { key = key, mods = M.pane_mods, action = M.activate_pane(dir) })
	end

	for dir, key in pairs(M.pane_resize) do
		table.insert(config.keys, { key = key, mods = M.pane_mods, action = M.resize_pane(dir) })
	end
end

M.pane_nav = {
	Left = "n",
	Down = "e",
	Up = "i",
	Right = "o",
}
M.pane_resize = {
	Left = "LeftArrow",
	Down = "DownArrow",
	Up = "UpArrow",
	Right = "RightArrow",
}
M.pane_mods = "CTRL"

---@param dir "Right" | "Left" | "Up" | "Down"
function M.activate_pane(dir)
	return wezterm.action_callback(function(window, pane)
		if M.is_vim(pane) then
			window:perform_action(act.SendKey({ key = M.pane_nav[dir], mods = M.pane_mods }), pane)
		else
			window:perform_action(act.ActivatePaneDirection(dir), pane)
		end
	end)
end

---@param dir "Right" | "Left" | "Up" | "Down"
function M.resize_pane(dir)
	return wezterm.action_callback(function(window, pane)
		if M.is_vim(pane) then
			window:perform_action(act.SendKey({ key = M.pane_resize[dir], mods = M.pane_mods }), pane)
		else
			window:perform_action(act.AdjustPaneSize({ dir, 3 }), pane)
			-- window:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
		end
	end)
end

function M.is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

return M
