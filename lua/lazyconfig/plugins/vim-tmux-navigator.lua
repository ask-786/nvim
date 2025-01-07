local keys = {
	{ '<C-h>', vim.cmd.TmuxNavigateLeft, 'n' },
	{ '<C-j>', vim.cmd.TmuxNavigateDown, 'n' },
	{ '<C-k>', vim.cmd.TmuxNavigateUp, 'n' },
	{ '<C-l>', vim.cmd.TmuxNavigateRight, 'n' },
}

return {
	'christoomey/vim-tmux-navigator',
	lazy = true,
	keys = keys,
}
