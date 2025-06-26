local map = require('lazyconfig.util').map_with_desc

return {
	dir = 'ask-786/translate.nvim',
	config = function()
		local translate = require('translate')

		translate.setup({
			key = os.getenv('GOOGLE_TRANSLATE_API_KEY'),
			translate_from = 'fr',
			translate_to = 'en',
		})

		print(
			'Translate: ' .. (os.getenv('GOOGLE_TRANSLATE_API_KEY') or 'No API Key')
		)
		map({ 'n', 'v' }, '<leader>tt', require('translate').translate, 'Translate')
	end,
}
