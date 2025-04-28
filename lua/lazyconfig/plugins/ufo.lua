local map = require('lazyconfig.util.init').map_with_desc

return {
	'kevinhwang91/nvim-ufo',
	dependencies = { 'kevinhwang91/promise-async' },
	config = function()
		vim.o.foldcolumn = '0'
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		map('n', '<leader>fl', 'zc', 'Close Fold')
		map('n', '<leader>fL', require('ufo').openAllFolds, 'Close All Fold')
		map('n', '<leader>lf', 'zo', 'Open Fold')
		map('n', '<leader>lF', require('ufo').closeAllFolds, 'Close All Fold')

		local handler = require('lazyconfig.util.ufo').customize_fold_text_handler
		local provider =
			require('lazyconfig.util.ufo').select_provider_with_chain_by_default()

		require('ufo').setup({
			fold_virt_text_handler = handler,
			provider_selector = provider,
		})
	end,
}
