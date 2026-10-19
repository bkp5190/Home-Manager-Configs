local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Match the Ghostty/kitty setup: JetBrains Mono NL + Catppuccin Frappe.
-- The "Nerd Font Mono" variant keeps glyphs cell-aligned and adds the icon
-- coverage the rounded tab bar (below) and tmux's Catppuccin plugin need.
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.color_scheme = "Catppuccin Frappe"
config.default_cursor_style = "SteadyBlock"
config.term = "xterm-256color"
config.enable_kitty_keyboard = true

-- macOS option key behaves like Alt (mirrors ghostty's macos-option-as-alt=left)
config.send_composed_key_when_left_alt_is_pressed = false

-- copy-on-select to the system clipboard (mirrors ghostty's copy-on-select=clipboard)
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

-- Rounded "pill" tab bar (Catppuccin Frappe), to match the tmux status line.
-- The fancy (native) tab bar can't render glyph-based edges, so this uses
-- the retro renderer with PowerLine half-circle glyphs from the Nerd Font.
config.use_fancy_tab_bar = false
config.tab_max_width = 32

local ROUNDED_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local ROUNDED_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

local frappe = {
	crust = "#232634",
	surface0 = "#414559",
	surface1 = "#51576d",
	blue = "#8caaee",
	text = "#c6d0f5",
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, effective_config, hover, max_width)
	local background = frappe.surface0
	local foreground = frappe.text

	if tab.is_active then
		background = frappe.blue
		foreground = frappe.crust
	elseif hover then
		background = frappe.surface1
		foreground = frappe.text
	end

	local edge_background = frappe.crust
	local edge_foreground = background

	local title = wezterm.truncate_right(tab_title(tab), max_width - 4)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = ROUNDED_LEFT },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = ROUNDED_RIGHT },
	}
end)

-- Windows and Tabs
config.keys = {
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "CMD", action = act.SpawnWindow },
	{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "t", mods = "CMD|SHIFT", action = act.PromptInputLine({
		description = "Set tab title",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	}) },

	-- Splits - tmux-style feel
	{ key = "\\", mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CMD|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },

	-- Navigate splits - cmd+arrow
	{ key = "LeftArrow", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD", action = act.ActivatePaneDirection("Down") },
}

return config
