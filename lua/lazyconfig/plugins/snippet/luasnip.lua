local config = function()
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

return {
	'L3MON4D3/LuaSnip',
	build = 'make install_jsregexp',
	config = config,
}
