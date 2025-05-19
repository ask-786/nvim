local map = require('lazyconfig.util').map_with_desc
local open_parallel_file = require('lazyconfig.util').open_parallel_file

vim.g.mapleader = ' '

local Diagnostics = {
	ALL = 0,
	ERROR = 1,
}

---@param count integer
---@param type? integer
---@return function
local function diagnostic_jump(count, type)
	return function()
		if type == Diagnostics.ERROR then
			vim.diagnostic.jump({
				count = count,
				severity = vim.diagnostic.severity.ERROR,
			})
		else
			vim.diagnostic.jump({ count = count })
		end
	end
end

map('n', '<leader>pv', vim.cmd.Oil, 'Oil')

map('v', 'J', ':m \'>+1<CR>gv=gv', 'Move Selected Lines Downwards')
map('v', 'K', ':m \'<-2<CR>gv=gv', 'Move Selected Lines Upwards')

map('n', '<C-d>', '<C-d>zz', 'Jump Half Page [D]ownwards')
map('n', '<C-u>', '<C-u>zz', 'Jump Half Page [U]pwards')

map('n', '<leader>vs', vim.cmd.vsplit, 'Split screen Vertically')
map('n', '<leader>hs', vim.cmd.split, 'Split screen Horizontally')

map('n', '<A-t>', function()
	vim.cmd.tabnew('.')
end, 'Create new Tab')
map('n', '<A-n>', vim.cmd.tabnext, 'Jump to next Tab')
map('n', '<A-p>', vim.cmd.tabprevious, 'Jump to previous Tab')

map({ 'n', 'v' }, '<leader>y', [["+y]], '[Y]ank to System Clipboard')
map('n', '<leader>Y', [["+Y]], '[Y]ank to System Clipboard')

map('n', '<leader>tsp', '<cmd>:InspectTree<CR>', 'Tree Sitter Playground')

map('n', '[d', diagnostic_jump(1, Diagnostics.ALL), 'Next Diagnostic message')
map('n', ']d', diagnostic_jump(-1, Diagnostics.ALL), 'Prev Diagnostic message')
map('n', '[ed', diagnostic_jump(1, Diagnostics.ERROR), 'Next Diagnostic Error')
map('n', ']ed', diagnostic_jump(-1, Diagnostics.ERROR), 'Prev Diagnostic Error')

map('n', '<leader>e', vim.diagnostic.open_float, 'Show Diagnostics')
map('n', '<leader>dg', vim.diagnostic.setqflist, '[D]ia[G]nostics')

map('t', '<Esc><Esc>', [[<C-\><C-n>]], 'Escape terminal mode')
map('n', '<leader>o', ':sp<CR>gF', 'Open file under cursor', { silent = true })
map('n', '<leader>tem', open_parallel_file('ts', 'html'), '')
map('n', '<leader>ty', open_parallel_file('html', 'ts'), '')

-- Copy current file path
map('n', '<leader>cp', function()
	vim.fn.setreg('+', vim.fn.expand('%'))
end, 'Copy Relative Path')
