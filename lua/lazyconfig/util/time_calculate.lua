local M = {};

-- Function to convert "HH:MM" to minutes
local function time_to_minutes(time_str)
	local hours, minutes = time_str:match("(%d+):(%d+)")
	return tonumber(hours) * 60 + tonumber(minutes)
end

-- Function to calculate total time in minutes
local function calculate_total_time(sessions)
	local total_minutes = 0
	for _, session in ipairs(sessions) do
		local punch_in_minutes = time_to_minutes(session.punch_in)
		local punch_out_minutes = time_to_minutes(session.punch_out)
		total_minutes = total_minutes + (punch_out_minutes - punch_in_minutes)
	end
	return total_minutes
end

-- Convert minutes to "HH:MM"
local function minutes_to_time(minutes)
	local hours = math.floor(minutes / 60)
	local mins = minutes % 60
	return string.format("%02d:%02d", hours, mins)
end

M.calculate_time = function()
	local ts_utils = require('nvim-treesitter.ts_utils')

	local node = ts_utils.get_node_at_cursor()

	if not node then return end

	local parent = node:parent();

	if not parent then return end

	if not parent:named() or not parent:type() == "pipe_table_row" then return end


	local children = vim.list_slice(parent:named_children(), 2, 7)

	local times = {};

	for i, child in ipairs(children) do
		local start_row, start_col, end_row, end_col = child:range();
		local text = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})

		if #text > 0 then
			local str = vim.trim(text[1])
			if str ~= "" then
				table.insert(times, vim.trim(text[1]))
			end
		end
	end

	print(vim.inspect(times))

	if #times % 2 ~= 0 then
		vim.notify("Can't calculate", vim.log.levels.WARN)
		return;
	end

	local sessions = {};

	for i = 1, #times, 2 do
		local session = {};

		session.punch_in = times[i];
		session.punch_out = times[i + 1];

		table.insert(sessions, session);
	end

	local total_minutes = calculate_total_time(sessions)
	local total_time = minutes_to_time(total_minutes)

	local start_row, start_col, end_row, end_col = node:range()
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { total_time })
end


return M;
