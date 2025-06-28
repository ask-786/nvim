local util = require('lazyconfig.util.lsp')

return {
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = { 'hrsh7th/cmp-nvim-lsp', },
		config = util.lsp_config,
	},
	{
		'mason-org/mason.nvim',
		lazy = false,
		opts = { ui = { border = 'rounded' } },
	},
	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
		opts = {
			automatic_installation = false,
			ensure_installed = { 'ts_ls', 'lua_ls' },
		},
	},
}
