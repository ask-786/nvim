local map = require('lazyconfig.util').map_with_desc

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

	local extra_opts = { silent = true }

	map({ 'i' }, '<C-K>', ls.expand, 'LuaSnip Expand', extra_opts)
	map({ 'i', 's' }, '<C-L>', jump(ls, true), 'LuaSnip Jump Forward', extra_opts)
	map({ 'i', 's' }, '<C-H>', jump(ls), 'LuaSnip Jump Backward', extra_opts)

	ls.filetype_extend('typescript', { 'tsdoc' })
	ls.filetype_extend('javascript', { 'jsdoc' })
	ls.filetype_extend('htmlangular', { 'html', 'angular' })
end

local function friendly_snippets_config()
	local from_vscode = require('luasnip.loaders.from_vscode')

	from_vscode.lazy_load()
	from_vscode.load_standalone({ path = '.vscode/ocw-v35.code-snippets' })
end

local deps = {
	{
		'rafamadriz/friendly-snippets',
		config = friendly_snippets_config,
	},
}

return {
	{
		'L3MON4D3/LuaSnip',
		build = 'make install_jsregexp',
		version = 'v2.*',
		dependencies = deps,
		config = luasnip_config,
	},
}
