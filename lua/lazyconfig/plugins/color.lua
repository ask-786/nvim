return {
	'folke/tokyonight.nvim',
	lazy = false,
	priority = 1000,
	cmd = function()
		vim.cmd.colorscheme('tokyonight-moon')
	end,
	opts = {
		transparent = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			sidebars = 'transparent',
			floats = 'transparent',
		},
	},
}
