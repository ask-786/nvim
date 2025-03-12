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
---@return table<string, string[]>
M.ft_list_factory = function(formatter, filetypes)
	local results = {}
	for _, ft in ipairs(filetypes) do
		results[ft] = { formatter }
	end
	return results
end

return M
