local on_attach = require('lazyconfig.util.lsp').on_attach
local capabilities = require('lazyconfig.util.lsp').capabilities

return {
	'pmizio/typescript-tools.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'neovim/nvim-lspconfig',
		'saghen/blink.cmp',
	},
	opts = {
		on_attach = on_attach,
		capabilities = capabilities(),
		handlers = {},
	},
}
