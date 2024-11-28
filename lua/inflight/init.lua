local M = {}

-- Floating window variables
local win_id = nil
local buf_id = nil
local command_sequence = ""
local MAX_SEQUENCE_LENGTH = 10

-- Function to show the floating panel
local function show_panel(text)
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		-- Update text if the window exists
		vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { text })
		return
	end

	-- Create a buffer for the floating panel
	buf_id = vim.api.nvim_create_buf(false, true) -- [No file, scratch buffer]
	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { text })

	-- Calc the window size and position
        local width = MAX_SEQUENCE_LENGTH
	local height = 1
	local col = math.floor((vim.o.columns - width) / 2)
	local row = 1

	-- Create the floating window
	win_id = vim.api.nvim_open_win(buf_id, false, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})
end

-- Function to hide the floating panel
local function hide_panel() 
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
		win_id = nil
		buf_id = nil
	end
end


-- Function to reset the command sequence
local function reset_sequence()
	command_sequence = ""
	hide_panel()
end

-- Function to update the command sequence
local function update_sequence(key)
	if #command_sequence >= MAX_SEQUENCE_LENGTH then
		command_sequence = key
	else
		command_sequence = command_sequence .. key
	end
	show_panel(command_sequence)
end

-- Hook into keypress events
local function setup_key_listener()
	vim.on_key(function(char)
		if char == vim.api.nvim_replace_termcodes("<Esc>", true, false, true) then
			reset_sequence()
			return
		end
		local mode = vim.fn.mode()
		if mode ~= "i" then
			update_sequence(char)
			return
		end
	end)
end

-- Hook into text changes to detect command execution
local function setup_text_changed_listener()
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "CursorMoved", "ModeChanged" }, {
		callback = function()
			reset_sequence()
		end,
	})
end


-- Test functions for debugging
function M.show_inflight()
	show_panel("InFlight panel")
end

-- Setup function to init the plugin
function M.setup()
	print("InFlight Plugin Loaded")
	setup_key_listener()
	setup_text_changed_listener()
end

return M
