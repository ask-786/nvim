return {
	'yetone/avante.nvim',
	event = 'VeryLazy',
	version = false,
	opts = { provider = 'gemini' },
	build = 'make',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
	},
}
