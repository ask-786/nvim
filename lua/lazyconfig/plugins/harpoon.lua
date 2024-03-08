local config = function()
	local harpoon = require('harpoon')

	harpoon:setup()

	vim.keymap.set('n', '<leader>a', function()
		harpoon:list():append()
	end, { desc = '[A]dd file (harpoon)' })
	vim.keymap.set('n', '<C-e>', function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = 'Toggle quickmenu (harpoon)' })

	vim.keymap.set('n', '<A-h>', function()
		harpoon:list():select(1)
	end, { desc = 'File 1 (harpoon)' })
	vim.keymap.set('n', '<A-j>', function()
		harpoon:list():select(2)
	end, { desc = 'File 2 (harpoon)' })
	vim.keymap.set('n', '<A-k>', function()
		harpoon:list():select(3)
	end, { desc = 'File 2 (harpoon)' })
	vim.keymap.set('n', '<A-l>', function()
		harpoon:list():select(4)
	end, { desc = 'File 4 (harpoon)' })
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
    lazy = true,
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = config,
}
