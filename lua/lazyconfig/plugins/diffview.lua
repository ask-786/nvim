local keys = {
	{ '<leader>df', ':DiffviewFileHistory %<cr>', 'n' },
	{ '<leader>dc', ':DiffviewClose<cr>', 'n' },
}

local config = function()
	require('diffview').setup({
		default_args = {
			DiffviewOpen = { '--imply-local' },
		},
	})
end

return {
	'sindrets/diffview.nvim',
	lazy = true,
	keys = keys,
	config = config,
}
