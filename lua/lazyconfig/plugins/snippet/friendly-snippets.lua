local config = function()
	local from_vscode = require('luasnip.loaders.from_vscode')

	from_vscode.lazy_load()
	from_vscode.load_standalone({
		path = '.vscode/ocw-v35.code-snippets',
	})
end

return {
	'rafamadriz/friendly-snippets',
	config = config,
}
