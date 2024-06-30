_G.get_status_line = function()
	local branch =
		vim.fn.system('git branch --show-current  2> /dev/null | tr -d \'\n\'')
	if branch and branch ~= '' then
		return branch
	else
		return ''
	end
end

vim.opt.guicursor = ''

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'both' }

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.colorcolumn = '80'
vim.opt.updatetime = 50

vim.opt.breakindent = true
vim.opt.statusline =
	'%{v:lua.get_status_line()} - %f %h%m%r%=%-14.(%l,%c%V%) %P'

vim.g.mapleader = ' '
