local ls = require('luasnip');
local from_vscode = require('luasnip.loaders.from_vscode');

vim.keymap.set({ 'i' }, '<C-K>', function () ls.expand() end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function () ls.jump(1) end,
	{ silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function () ls.jump(-1) end,
	{ silent = true }
)

vim.keymap.set({ 'i', 's' }, '<C-E>', function ()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

ls.filetype_extend('angular', { 'html' })
from_vscode.lazy_load()
from_vscode.load_standalone({
	path = '.vscode/ocw-v35.code-snippets'
})