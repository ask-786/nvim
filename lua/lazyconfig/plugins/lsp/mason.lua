local config = function()
	require('mason').setup({
		ui = {
			border = 'rounded',
		},
	})
end

return {
	'williamboman/mason.nvim',
	lazy = false,
	config = config,
}
