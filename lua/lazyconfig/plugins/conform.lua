local prettier_fts = require('lazyconfig.util.conform').prettier_fts
local create_ft_list = require('lazyconfig.util.conform').create_ft_list

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
	--- @module 'conform'
	--- @type conform.setupOpts
	opts = {
		notify_on_error = false,
		default_format_opts = {
			lsp_format = 'fallback',
			stop_after_first = true,
			timeout_ms = 1500,
			async = true,
		},
		formatters_by_ft = vim.tbl_deep_extend(
			'force',
			create_ft_list('prettier', prettier_fts),
			{
				lua = { 'stylua' },
				python = { 'isort' },
			}
		),
	},
}
