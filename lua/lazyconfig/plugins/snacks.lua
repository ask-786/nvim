return {
	'folke/snacks.nvim',
	priority = 1000,
	lazy = false,
	---@module 'snacks'
	---@type snacks.Config
	opts = {
		bigfile = {
			enabled = true,
			notify = false,
		},
		image = { enabled = true },
	},
}
