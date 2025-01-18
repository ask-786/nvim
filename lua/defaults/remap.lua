local map = require('lazyconfig.util').map_with_desc
local calculate_time = require('lazyconfig.util.time_calculate').calculate_time

vim.g.mapleader = ' '

---@param count integer
---@param error_only? boolean
---@return function
local function diagnostic_jump(count, error_only)
	return function()
		if error_only == true then
			vim.diagnostic.jump({
				count = count,
				severity = vim.diagnostic.severity.ERROR,
			})
		else
			vim.diagnostic.jump({ count = count })
		end
	end
end

map('n', '<leader>pv', vim.cmd.Ex, 'Ex')

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

map('n', '[d', diagnostic_jump(1), 'Next Diagnostic message')
map('n', ']d', diagnostic_jump(-1), 'Prev Diagnostic message')
map('n', '[ed', diagnostic_jump(1, true), 'Next Diagnostic Error')
map('n', ']ed', diagnostic_jump(-1, true), 'Prev Diagnostic Error')

map('n', '<leader>e', vim.diagnostic.open_float, 'Show Diagnostics')
map('n', '<leader>dg', vim.diagnostic.setqflist, '[D]ia[G]nostics')

map('t', '<Esc><Esc>', [[<C-\><C-n>]], 'Escape terminal mode')
map('n', '<leader>o', ':sp<CR>gF', 'Open file under cursor', { silent = true })

--TODO: to be removed
map('n', '<leader>total', calculate_time, 'Calculate total time')
