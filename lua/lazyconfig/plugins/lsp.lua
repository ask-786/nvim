local helpers = require('lazyconfig.helpers')

return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		config = helpers.null_ls_config,
	},
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
		},
		config = helpers.lsp_config,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'VonHeikemen/lsp-zero.nvim',
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		config = helpers.mason_lsp_config,
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = function()
			require('mason').setup({
				ui = {
					border = 'rounded',
				},
			})
		end,
	},
}
