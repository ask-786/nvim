local config = function()
	require('fidget').setup({
		notification = {
			window = {
				winblend = 0,
			},
		},
	})
end

return {
	'j-hui/fidget.nvim',
	config = config,
}