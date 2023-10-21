local wezterm = require("wezterm")

local act = wezterm.action
local M = {}

-- M.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
M.mod = "SHIFT|CTRL"
M.smart_split = wezterm.action_callback(function(window, pane)
	local dim = pane:get_dimensions()
	if dim.pixel_height > dim.pixel_width then
		window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	end
end)

M.smart_close = function(pane_or_window, mods, key)
	return wezterm.action_callback(function(window, pane)
		if M.is_vim(pane) then
			window:perform_action({ SendKey = { key = key, mods = mods } }, pane)
		else
			if pane_or_window == "pane" then
				window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
			else
				window:perform_action(act.CloseCurrentTab({ confirm = true }), pane)
			end
		end
	end)
end

---@param config Config
function M.setup(config)
	config.disable_default_key_bindings = true
	-- config.leader = M.leader
	config.keys = {
		-- { mods = "LEADER", key = "a", action = act.SendKey({ key = "a", mods = "CTRL" }) },
		-- Scrollback
		{ mods = M.mod, key = "u", action = act.ScrollByPage(-0.5) },
		{ mods = M.mod, key = "d", action = act.ScrollByPage(0.5) },
		-- { mods = M.mod, key = "o", action = act({ ActivateTabRelative = 1 }) },
		-- { mods = M.mod, key = "n", action = act({ ActivateTabRelative = -1 }) },
		-- New Tab
		{ mods = M.mod, key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		-- close pane
		{ mods = "CTRL", key = "q", action = M.smart_close("pane", "CTRL", "q") },
		-- close pane
		-- { mods = "CTRL", key = "w", action = M.smart_close("tab", "CTRL", "w") },
		-- Splits
		{ mods = M.mod, key = "Enter", action = M.smart_split },
		{
			mods = M.mod,
			key = "n",
			action = act.SplitPane({ direction = "Left", size = { Percent = 50 } }),
		},
		{
			mods = M.mod,
			key = "e",
			action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
		},
		{
			mods = M.mod,
			key = "i",
			action = act.SplitPane({ direction = "Up", size = { Percent = 50 } }),
		},
		{
			mods = M.mod,
			key = "o",
			action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
		},
		-- Move Tabs
		{ mods = M.mod, key = ">", action = act.MoveTabRelative(1) },
		{ mods = M.mod, key = "<", action = act.MoveTabRelative(-1) },
		-- Acivate Tabs
		{ mods = M.mod, key = "}", action = act({ ActivateTabRelative = 1 }) },
		{ mods = M.mod, key = "{", action = act({ ActivateTabRelative = -1 }) },
		{ mods = M.mod, key = "r", action = wezterm.action.RotatePanes("Clockwise") },
		-- show the pane selection mode, but have it swap the active and selected panes
		{ mods = M.mod, key = "s", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
		-- Clipboard
		{ mods = M.mod, key = "c", action = act.CopyTo("Clipboard") },
		{ mods = M.mod, key = "Space", action = act.QuickSelect },
		{ mods = M.mod, key = "x", action = act.ActivateCopyMode },
		{ mods = M.mod, key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
		{ mods = M.mod, key = "v", action = act.PasteFrom("Clipboard") },
		{ mods = M.mod, key = "z", action = act.TogglePaneZoomState },
		{ mods = M.mod, key = "p", action = act.ActivateCommandPalette },
		{ mods = M.mod, key = "?", action = act.ShowDebugOverlay },
		-- extended keys
		-- { mods = "CTRL", key = "h", action = act.SendString("\x1b[104;5u") },
		-- { mods = "CTRL", key = "m", action = act.SendString("\x1b[109;5u") },
		-- { mods = "CTRL", key = "i", action = act.SendString("\x1b[105;5u") },
		-- { mods = "CTRL", key = "Enter", action = act.SendString("\x1b[105;5u") },
		-- { mods = "SHIFT", key = "\r", action = act.SendString("\033[\015;2u") },
		M.smart_nav("resize", "CTRL", "LeftArrow", "Right"),
		M.smart_nav("resize", "CTRL", "RightArrow", "Left"),
		M.smart_nav("resize", "CTRL", "UpArrow", "Up"),
		M.smart_nav("resize", "CTRL", "DownArrow", "Down"),
		M.smart_nav("move", "CTRL", "n", "Left"),
		M.smart_nav("move", "CTRL", "e", "Down"),
		M.smart_nav("move", "CTRL", "i", "Up"),
		M.smart_nav("move", "CTRL", "o", "Right"),
	}
end

function M.smart_nav(resize_or_move, mods, key, dir)
	local event = "smart_" .. resize_or_move .. "_" .. dir
	wezterm.on(event, function(win, pane)
		if M.is_vim(pane) then
			win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
		else
			if resize_or_move == "resize" then
				win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
			else
				win:perform_action({ ActivatePaneDirection = dir }, pane)
			end
		end
	end)
	return {
		key = key,
		mods = mods,
		action = wezterm.action.EmitEvent(event),
	}
end

function M.is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

return M
