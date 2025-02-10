local M = {}

---@param target_type string
---@return TSNode | nil
local function is_cursor_in_node_type(target_type)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1 -- Convert to 0-based row
	local col = cursor[2]
	local node = vim.treesitter.get_node({ pos = { row, col } })

	while node do
		if node:type() == target_type then
			return node
		end
		node = node:parent()
	end

	return nil
end

M.convert = function()
	if vim.bo.filetype ~= 'typescript' then
		vim.notify('This only works in typescript files', vim.log.levels.WARN)
		return
	end

	local obj = is_cursor_in_node_type('object')

	if not obj then
		vim.notify('Place your cursor inside an object', vim.log.levels.WARN)
		return
	end

	for i, child in pairs(obj:named_children()) do
		if child:type() ~= 'pair' then
			return
		end

		local value_node = child:field('value')

		if not value_node then
			return
		end

		local first_node = value_node[1]

		if first_node and first_node:type() then
		end
	end
end

return M
