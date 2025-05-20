return {
	'yetone/avante.nvim',
	event = 'VeryLazy',
	version = false,
	opts = { provider = 'claude' },
	build = 'make',
	enabled = false,
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'stevearc/dressing.nvim',
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
		{
			'HakonHarnes/img-clip.nvim',
			event = 'VeryLazy',
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { 'markdown', 'Avante' },
				latex = { enabled = false },
			},
			ft = { 'markdown', 'Avante' },
		},
	},
}
