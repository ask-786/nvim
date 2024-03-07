local config = function()
	local null_ls = require('null-ls')

	null_ls.setup({
		on_attach = require('lazyconfig.plugins.lsp.helpers').onattach,
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,
		},
	})
end

return {
	'nvimtools/none-ls.nvim',
	config = config,
}
