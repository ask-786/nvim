return {
	'yetone/avante.nvim',
	event = 'VeryLazy',
	version = false,
	opts = {
		provider = 'gemini',
		cursor_applying_provider = 'gemini',
		behaviour = { enable_cursor_planning_mode = true },
	},
	build = 'make',
	dependencies = {
		'stevearc/dressing.nvim',
		'MunifTanjim/nui.nvim',
	},
}
