local config = function()
	local lsp_zero = require('lsp-zero')
	lsp_zero.extend_lspconfig()

	require('mason-lspconfig').setup({
		ensure_installed = { 'tsserver', 'lua_ls' },
		handlers = { lsp_zero.default_setup },
	})
end

return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		'VonHeikemen/lsp-zero.nvim',
		'williamboman/mason.nvim',
        'neovim/nvim-lspconfig'
	},
	config = config,
}
