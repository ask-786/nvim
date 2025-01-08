local M = {}

M.prettier_fts = {
	'javascript',
	'javascriptreact',
	'typescript',
	'typescriptreact',
	'html',
	'css',
	'scss',
	'markdown',
	'htmlangular',
	'yaml',
	'json',
}

---@param formatter string
---@param filetypes string[]
M.create_ft_list = function(formatter, filetypes)
	local results = {}
	for _, ft in ipairs(filetypes) do
		results[ft] = { formatter }
	end
	return results
end

return M
