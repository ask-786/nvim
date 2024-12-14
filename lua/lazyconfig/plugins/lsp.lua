local util = require('lazyconfig.util')

return {
	{
		'nvimtools/none-ls.nvim',
		config = util.null_ls_config,
	},
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = util.lsp_config,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		opts = {
			ui = {
				border = 'rounded',
			},
		},
	},
}
