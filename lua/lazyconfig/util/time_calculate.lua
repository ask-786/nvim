local M = {}

-- Function to convert "HH:MM" to minutes
local function time_to_minutes(time_str)
	local hours, minutes = time_str:match('(%d+):(%d+)')

	if not hours or not minutes then
		return 0
	end

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
	return string.format('%02d:%02d', hours, mins)
end

M.calculate_time = function()
	local parsed = vim.treesitter.query.parse(
		'markdown',
		[[
			(document
				(section
					(pipe_table
						(pipe_table_row) @row)))
		]]
	)

	local root = vim.treesitter.get_parser(0, 'markdown'):parse()[1]:root()
	local row_index = 0

	for _, parent in parsed:iter_captures(root, 0, 1, -1) do
		local children = parent:named_children()
		local sliced_children = vim.list_slice(children, 2, #children - 1)

		row_index = row_index + 1

		local times = {}

		for _, child in ipairs(sliced_children) do
			local text = vim.treesitter.get_node_text(child, 0)

			local str = vim.trim(text)

			if str ~= '' then
				table.insert(times, str)
			end
		end

		local sessions = {}

		for i = 1, #times, 2 do
			local session = {}

			session.punch_in = times[i]
			session.punch_out = times[i + 1]

			if session.punch_in and session.punch_out then
				table.insert(sessions, session)
			end
		end

		local total_minutes = calculate_total_time(sessions)
		local total_time = minutes_to_time(total_minutes)

		local start_row, start_col, end_row, end_col = children[#children]:range()

		if not start_row or not start_col or not end_row or not end_col then
			return
		end

		vim.api.nvim_buf_set_text(
			0,
			start_row,
			start_col,
			end_row,
			end_col,
			{ ' ' .. total_time .. ' ' }
		)
	end
end

return M
