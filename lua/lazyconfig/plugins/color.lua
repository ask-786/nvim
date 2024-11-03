return {
	'catppuccin/nvim',
	name = 'catppuccin',
	lazy = false,
	priority = 1000,
	cmd = function()
		vim.cmd.colorscheme('catppuccin')
	end,
	opts = {
		flavour = 'mocha',
		transparent_background = true,
		custom_highlights = function(colors)
			return {
				CursorLine = { bg = colors.mantle },
			}
		end,
		integrations = {
			diffview = true,
			harpoon = true,
			mason = true,
			fidget = true,
		},
	},
}
