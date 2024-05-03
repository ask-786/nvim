local function luasnip_config()
	local ls = require('luasnip')

	vim.keymap.set({ 'i' }, '<C-K>', function()
		ls.expand()
	end, { silent = true, desc = 'LuaSnip Expand' })

	vim.keymap.set({ 'i', 's' }, '<C-L>', function()
		ls.jump(1)
	end, { silent = true, desc = 'LuaSnip Jump Forward' })

	vim.keymap.set({ 'i', 's' }, '<C-J>', function()
		ls.jump(-1)
	end, { silent = true, desc = 'LuaSnip Jump Backward' })

	ls.filetype_extend('typescript', { 'tsdoc' })
	ls.filetype_extend('javascript', { 'jsdoc' })
end

local function friendly_snippets_config()
	local from_vscode = require('luasnip.loaders.from_vscode')

	from_vscode.lazy_load()
	from_vscode.load_standalone({
		path = '.vscode/ocw-v35.code-snippets',
	})
end

return {
	{
		'L3MON4D3/LuaSnip',
		build = 'make install_jsregexp',
		config = luasnip_config,
	},
	{
		'rafamadriz/friendly-snippets',
		config = friendly_snippets_config,
	},
}
