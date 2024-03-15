vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Ex' })

vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move Selected Lines Downwards' })
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move Selected Lines Upwards' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'No Idea' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jump Half Page [D]ownwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jump Half Page [U]pwards' })
vim.keymap.set('n', '<leader>vs', vim.cmd.vsplit, { desc = 'Split screen Vertically' })
vim.keymap.set('n', '<leader>hs', vim.cmd.split, { desc = 'Split screen Horizontally' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to System Clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank to System Clipboard' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dg', vim.diagnostic.setqflist, { desc = '[D]ia[G]nostics' })
vim.keymap.set('n', '<leader>tsp', '<cmd>:InspectTree<cr>', { desc = '[D]ia[G]nostics' })
