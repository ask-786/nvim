local calculate_time = require('lazyconfig.util.time_calculate').calculate_time
local map = require('lazyconfig.util').map_with_desc

local config = function()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = { 'javascript', 'typescript', 'lua' },
		sync_install = false,
		ignore_install = {},
		modules = {},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = false, -- set to `false` to disable one of the mappings
				node_incremental = '(',
				node_decremental = ')',
			},
		},
	})

	--TODO: to be removed
	map('n', '<leader>total', calculate_time, 'Calculate total time')
end

return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = config,
}
