local util = require('lazyconfig.util.lsp')

return {
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { 'williamboman/mason-lspconfig.nvim', 'saghen/blink.cmp' },
		config = util.lsp_config,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		opts = { ui = { border = 'single' } },
	},
}
