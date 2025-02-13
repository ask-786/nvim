return {
	'kevinhwang91/nvim-ufo',
	dependencies = { 'kevinhwang91/promise-async' },
	config = function()
		vim.o.foldcolumn = '0'
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		vim.keymap.set('n', '<leader>fl', 'zc')
		vim.keymap.set('n', '<leader>lf', 'zo')

		local handler = require('lazyconfig.util.ufo').customize_fold_text_handler
		local provider =
			require('lazyconfig.util.ufo').select_provider_with_chain_by_default()

		require('ufo').setup({
			fold_virt_text_handler = handler,
			provider_selector = provider,
		})
	end,
}
