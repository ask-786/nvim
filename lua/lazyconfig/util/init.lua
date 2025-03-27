---@diagnostic disable: duplicate-set-field

local M = {}

---@param mode string | table
---@param lhs string
---@param rhs function | string
---@param desc string
---@param extra_opts? table
M.map_with_desc = function(mode, lhs, rhs, desc, extra_opts)
	local opts = vim.tbl_deep_extend('force', { desc = desc }, extra_opts or {})

	vim.keymap.set(mode, lhs, rhs, opts)
end

M.open_parallel_file = function(curr_ext, sub_ext)
	return function()
		local path =
			vim.fn.expand('%'):gsub('%.' .. curr_ext .. '$', '.' .. sub_ext)
		if vim.fn.findfile(path, '**/') ~= '' then
			vim.cmd('vsplit')
			vim.cmd('wincmd l')
			vim.cmd('edit ' .. path)
		else
			vim.notify('Cound\'nt find file', vim.log.levels.WARN)
		end
	end
end

return M
