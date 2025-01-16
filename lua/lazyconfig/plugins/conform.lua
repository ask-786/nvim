local conform_util = require('lazyconfig.util.conform')

return {
	'stevearc/conform.nvim',
	keys = {
		{
			'<leader>ff',
			function()
				require('conform').format()
			end,
			mode = { 'n', 'x' },
			desc = '[F]ormat [F]ile',
		},
	},
	opts = {
		notify_on_error = false,
		default_format_opts = {
			lsp_format = 'fallback',
			async = true,
		},
		formatters_by_ft = vim.tbl_deep_extend(
			'force',
			conform_util.create_ft_list('prettier', conform_util.prettier_fts),
			{
				lua = { 'stylua' },
				python = { 'isort' },
			}
		),
	},
}
