local cmp = require('cmp');

cmp.setup({
	mapping = {
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({ select = true }),

		-- Navigate between snippet placeholder
		['<C-p>'] = cmp.mapping(function ()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = 'insert' })
			else
				cmp.complete()
			end
		end),
		['<C-n>'] = cmp.mapping(function ()
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
		expand = function (args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	}, {
		{ name = 'buffer' },
	})
});