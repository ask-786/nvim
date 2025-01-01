---@diagnostic disable: duplicate-set-field

local M = {}

---@param mode string | table
---@param lhs string
---@param rhs function | string
---@param desc string
---@param extra_opts? table
M.map_with_desc = function(mode, lhs, rhs, desc, extra_opts)
	local opts = vim.tbl_deep_extend('force', { desc = desc }, extra_opts or {});

	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
