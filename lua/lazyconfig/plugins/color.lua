local config = function()
	require('catppuccin').setup({
		flavour = 'mocha', -- latte, frappe, macchiato, mocha
		transparent_background = true, -- disables setting the background color.tree
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
			mini = {
				enabled = true,
				indentscope_color = '',
			},
		},
	})
end

return {
	'catppuccin/nvim',
	name = 'catppuccin',
	lazy = false,
	priority = 1000,
	cmd = function()
		vim.cmd.colorscheme('catppuccin')
	end,
	config = config,
}
