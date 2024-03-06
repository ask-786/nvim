local keys = {
	{ '<C-h>', vim.cmd.TmuxNavigateLeft },
	{ '<C-j>', vim.cmd.TmuxNavigateDown },
	{ '<C-k>', vim.cmd.TmuxNavigateUp },
	{ '<C-l>', vim.cmd.TmuxNavigateRight },
}

return {
	'christoomey/vim-tmux-navigator',
	keys = keys,
}