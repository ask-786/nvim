local get_opts = function()
	local luasnip = require('luasnip')

	return {
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
		appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
		signature = { enabled = true, window = { border = 'rounded' } },
		sources = {
			default = { "lazydev", 'lsp', 'path', 'luasnip', 'buffer', "dadbod" },
			cmdline = {},
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 10 },
				lsp = { fallbacks = {}, score_offset = 9 },
				path = { score_offset = 8 },
				luasnip = { score_offset = 7 },
			},
		},
		completion = {
			menu = { auto_show = true, border = 'rounded' },
			list = { selection = 'auto_insert' },
			trigger = {
				show_on_insert_on_trigger_character = false,
				show_on_trigger_character = false
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = 'rounded' },
			},
		},
		snippets = {
			expand = function(snippet) luasnip.lsp_expand(snippet) end,
			active = function(filter)
				if filter and filter.direction then
					return luasnip.jumpable(filter.direction)
				end
				return luasnip.in_snippet()
			end,
			jump = function(direction) luasnip.jump(direction) end,
		},
	}
end

return {
	'saghen/blink.cmp',
	dependencies = { 'L3MON4D3/LuaSnip' },
	build = "cargo build --release",
	opts = get_opts,
}
