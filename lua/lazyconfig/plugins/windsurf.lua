return {
	'exafunction/windsurf.nvim',
	config = function()
		local codeium = require('codeium')

		codeium.setup({
			enable_cmp_source = false,
			quiet = true,
			virtual_text = {
				enabled = true,
				key_bindings = {
					accept = '<Tab>',
					accept_line = false,
					clear = false,
					next = '<M-]>',
					prev = '<M-[>',
				},
			},
		})
	end,
}
