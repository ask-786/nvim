return {
	'tpope/vim-fugitive',
	lazy = false,
	keys = {
		{ '<leader>gs', ':Git<CR>', 'n' },
		{ '<leader>gl', ':Git log<CR>', 'n' },
		{ '<leader>gB', ':Git blame<CR>', 'n' },
	},
}
