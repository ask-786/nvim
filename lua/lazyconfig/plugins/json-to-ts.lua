local map = require('lazyconfig.util').map_with_desc

return {
	'ask-786/json-to-ts.nvim',
	config = function()
		local json_to_ts = require('json-to-ts')
		map('n', '<leader>jt', json_to_ts.generate, 'Convert JSON to TS')
	end,
}
