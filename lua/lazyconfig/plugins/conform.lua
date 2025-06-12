local prettier_fts = require('lazyconfig.util.conform').prettier_fts
local ft_factory = require('lazyconfig.util.conform').ft_list_factory

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
			timeout_ms = 3000,
			async = true,
		},
		formatters_by_ft = vim.tbl_deep_extend(
			'force',
			ft_factory('prettier', prettier_fts),
			ft_factory('pg_format', { 'sql', 'mysql' }),
			{
				lua = { 'stylua' },
				python = { 'isort' },
				c = { 'clang-format' },
				sh = { 'shfmt' },
			}
		),
	},
}
