local util = require('lazyconfig.util')

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 50 })
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = vim.api.nvim_create_augroup('remove-trailing-space', { clear = true }),
	pattern = '*',
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('ask-lsp-attach', { clear = true }),
	callback = util.lsp_highlight,
})
