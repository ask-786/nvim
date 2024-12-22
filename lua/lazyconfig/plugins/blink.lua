local get_opts = function()
	local luasnip = require('luasnip')

	return {
		keymap = {
			['<CR>'] = { 'select_and_accept', 'fallback' },
			['<C-y>'] = { 'select_and_accept', 'fallback' },
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'show', 'select_next', 'fallback' },
			['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},
		sources = {
			default = { 'lsp', 'path', 'luasnip', 'buffer', "dadbod" },
			cmdline = {},
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		signature = {
			enabled = true,
			window = { border = 'rounded' }
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = 'rounded' }
			},
			menu = {
				auto_show = true,
				border = 'rounded'
			},
			list = { selection = 'auto_insert' }
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
