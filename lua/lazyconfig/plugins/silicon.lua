return {
	'michaelrommel/nvim-silicon',
	lazy = true,
	cmd = 'Silicon',
	opts = {
		font = 'CaskaydiaMono Nerd Font=34;Noto Color Emoji=34',
		to_clipboard = true,
		theme = 'Catppuccin Mocha',
		window_title = function()
			return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':~:.')
		end,
	},
}
