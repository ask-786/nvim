local map = require('lazyconfig.util').map_with_desc

local config = function()
	local harpoon = require('harpoon')

	harpoon:setup()

	map('n', '<leader>a', function() harpoon:list():add() end, '[A]dd file (harpoon)')
	map('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'Toggle quickmenu (harpoon)')

	local keys = { 'j', 'j', 'k', 'l' }

	for i, value in ipairs(keys) do
		map('n', '<A-' .. value .. '>', function() harpoon:list():select(i) end, 'File ' .. i .. ' (harpoon)')
	end
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	config = config,
}
