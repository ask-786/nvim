---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
	keymap = {
		preset = 'none',
		['<CR>'] = { 'select_and_accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept', 'fallback' },
		['<C-e>'] = { 'hide', 'fallback' },
		['<C-p>'] = { 'show', 'select_prev', 'fallback' },
		['<C-n>'] = { 'show', 'select_next', 'fallback' },
		['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
	},
	appearance = { use_nvim_cmp_as_default = true },
	signature = { enabled = true, window = { border = 'rounded' } },
	cmdline = { enabled = false },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
		per_filetype = {
			sql = { 'snippets', 'dadbod', 'buffer' },
			lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
			gitcommit = { 'snippets', 'buffer' },
		},
		providers = {
			dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
			lazydev = {
				name = 'LazyDev',
				module = 'lazydev.integrations.blink',
				score_offset = 10,
			},
			lsp = { fallbacks = {}, score_offset = 5 },
		},
	},
	completion = {
		menu = { auto_show = true, border = 'rounded' },
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		trigger = { show_on_insert_on_trigger_character = false },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = 'rounded' },
		},
	},
	snippets = { preset = 'luasnip' },
}

return {
	'saghen/blink.cmp',
	dependencies = { 'L3MON4D3/LuaSnip' },
	version = '*',
	opts = opts,
}
