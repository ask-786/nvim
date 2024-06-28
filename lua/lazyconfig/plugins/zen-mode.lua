local config = function()
	vim.keymap.set('n', '<leader>zz', function()
		local zm = require('zen-mode')

		zm.setup({
			window = {
				width = 1.0,
				options = {},
			},
		})

		zm.toggle()
		vim.wo.wrap = false
		vim.wo.number = true
		vim.wo.rnu = true
	end, { desc = 'Zen Mode' })
end

return {
	'folke/zen-mode.nvim',
	config = config,
}
