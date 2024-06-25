local config = function()
	local harpoon = require('harpoon')

	harpoon:setup()

	vim.keymap.set('n', '<leader>a', function()
		harpoon:list():add()
	end, { desc = '[A]dd file (harpoon)' })

	vim.keymap.set('n', '<C-e>', function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = 'Toggle quickmenu (harpoon)' })

	local keys = { 'h', 'j', 'k', 'l' }

	for key, value in ipairs(keys) do
		vim.keymap.set('n', '<A-' .. value .. '>', function()
			harpoon:list():select(key)
		end, { desc = 'File ' .. key .. ' (harpoon)' })
	end
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = config,
}
