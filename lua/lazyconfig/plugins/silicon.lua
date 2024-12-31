return {
	'krivahtoo/silicon.nvim',
	lazy = true,
	build = "./install.sh",
	cmd = 'Silicon',
	opts = {
		output = {
			file = "",
			clipboard = true,
			path = "~/Pictures/silicon",
			format = "silicon_[year][month][day]_[hour][minute][second].png",
		},
		font = 'JetBrainsMonoNerdFont',
		theme = 'Catppuccin Mocha',
		background = '#AAAAFF',
		window_title = function()
			return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':~:.')
		end,
	}
}
