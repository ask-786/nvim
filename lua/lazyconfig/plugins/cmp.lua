local config = function()
	local cmp = require('cmp')
	local auto_pairs = require('nvim-autopairs.completion.cmp')
	local lspkind = require('lspkind')

	cmp.event:on('confirm_done', auto_pairs.on_confirm_done())

	cmp.setup({
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = lspkind.cmp_format({
				mode = 'symbol',
				menu = {
					buffer = '[Buffer]',
					nvim_lsp = '[LSP]',
					luasnip = '[LuaSnip]',
					nvim_lua = '[Lua]',
					latex_symbols = '[Latex]',
				},
				ellipsis_char = '...',
				show_labelDetails = true,
			}),
		},
		mapping = {
			['<CR>'] = cmp.mapping(function(fallback)
				if cmp.visible() and cmp.get_selected_entry() then
					cmp.confirm({ select = false })
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<C-p>'] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = 'insert' })
				else
					cmp.complete()
				end
			end),
			['<C-n>'] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = 'insert' })
				else
					cmp.complete()
				end
			end),

			-- Scroll up and down in the completion documentation
			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'cmp-tw2css' },
			{ name = 'path' },
		}, {
			{ name = 'buffer' },
		}),
	})
end

return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'saadparwaiz1/cmp_luasnip',
		'VonHeikemen/lsp-zero.nvim',
		'windwp/nvim-autopairs',
		'onsails/lspkind.nvim',
	},
	config = config,
}
