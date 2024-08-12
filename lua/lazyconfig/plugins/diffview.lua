local keys = {
	{ '<leader>df', ':DiffviewFileHistory %<cr>', 'n' },
	{ '<leader>dc', ':DiffviewClose<cr>', 'n' },
}

return {
	'sindrets/diffview.nvim',
	lazy = true,
	keys = keys,
	opts = {
		default_args = {
			DiffviewOpen = { '--imply-local' },
		},
	},
}
