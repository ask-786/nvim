local config = function()
	vim.keymap.set('n', '<leader>zz', function()
		require('zen-mode').setup({
			window = {
				width = 1.0,
				options = {},
			},
		})
		require('zen-mode').toggle()
		vim.wo.wrap = false
		vim.wo.number = true
		vim.wo.rnu = true
	end, { desc = 'Zen Mode' })
end

return {
	'folke/zen-mode.nvim',
	lazy = true,
	config = config,
}
