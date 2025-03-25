return {
	'rose-pine/neovim',
	name = 'rose-pine',
	lazy = false,
	priority = 1000,
	cmd = function()
		vim.cmd.colorscheme('rose-pine-moon')
	end,
	opts = {
		styles = {
			transparency = true,
		},
	},
}
