local config = function()
	local null_ls = require('null-ls')

	null_ls.setup({
		on_attach = require('lazyconfig.plugins.lsp.helpers').on_attach,
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.google_java_format,
			null_ls.builtins.formatting.pretty_php,
		},
	})
end

return {
	'nvimtools/none-ls.nvim',
	config = config,
}
