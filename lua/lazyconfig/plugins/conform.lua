return {
	'stevearc/conform.nvim',
	keys = {
		{
			'<leader>ff',
			function()
				require('conform').format({ async = true, lsp_format = 'fallback' })
			end,
			mode = { 'n', 'x' },
			desc = '[F]ormat buffer',
		},
	},
	opts = {
		notify_on_error = false,
		default_format_opts = {
			lsp_format = 'fallback',
		},
		formatters_by_ft = vim.tbl_deep_extend(
			'force',
			{ lua = { 'stylua' }, python = { 'isort' } },
			(function()
				local filetypes = {
					'javascript',
					'javascriptreact',
					'typescript',
					'typescriptreact',
					'html',
					'css',
					'scss',
					'markdown',
					'htmlangular',
				}
				local results = {}
				for _, ft in ipairs(filetypes) do
					results[ft] = { 'prettier' }
				end
				return results
			end)()
		),
	},
}
