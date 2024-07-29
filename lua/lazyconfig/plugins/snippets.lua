---Keymap func
---@param mode string | table
---@param lhs string
---@param rhs string | function
---@param desc string
local function map(mode, lhs, rhs, desc)
	local opts = {}

	opts.desc = desc
	opts.silent = true

	vim.keymap.set(mode, lhs, rhs, opts)
end

---Luasnip jump
---@param ls table
---@param forward? boolean
local function jump(ls, forward)
	return function()
		if forward then
			ls.jump(1)
		else
			ls.jump(-1)
		end
	end
end

local luasnip_config = function(opts)
	local ls = require('luasnip')

	if opts then
		require('luasnip').config.setup(opts)
	end

	--stylua: ignore start
	map({ 'i' }, '<C-K>', ls.expand, 'LuaSnip Expand' )
	map({ 'i', 's' }, '<C-L>', jump(ls, true),'LuaSnip Jump Forward' )
	map({ 'i', 's' }, '<C-H>', jump(ls) , 'LuaSnip Jump Backward' )
	--stylua: ignore end

	ls.filetype_extend('typescript', { 'tsdoc' })
	ls.filetype_extend('javascript', { 'jsdoc' })
	ls.filetype_extend('htmlangular', { 'html' })
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
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = luasnip_config,
	},
	{
		'rafamadriz/friendly-snippets',
		config = friendly_snippets_config,
	},
}
