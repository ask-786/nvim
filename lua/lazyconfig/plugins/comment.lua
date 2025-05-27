return {
	'numToStr/Comment.nvim',
	event = 'BufEnter',
	dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
	config = function()
		local comment = require('Comment')
		local ts_commentstring =
			require('ts_context_commentstring.integrations.comment_nvim')
		local ft = require('Comment.ft')

		---@diagnostic disable-next-line: param-type-mismatch
		ft.set('htmlangular', ft.get('html'))

		---@diagnostic disable-next-line: missing-fields
		comment.setup({
			pre_hook = ts_commentstring.create_pre_hook(),
		})
	end,
}
