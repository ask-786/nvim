_G.get_oil_winbar = function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require('oil').get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ':~')
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		keymaps = {
			['<CR>'] = function()
				local oil = require('oil')
				local entry = oil.get_cursor_entry()
				if not entry then
					return
				end

				local abs_path = vim.fs.joinpath(oil.get_current_dir(), entry.name)
				local cwd = vim.fn.getcwd()

				local path_to_open
				if abs_path:sub(1, #cwd) == cwd then
					path_to_open = vim.fn.fnamemodify(abs_path, ':.')
				else
					path_to_open = abs_path
				end

				vim.cmd('edit ' .. vim.fn.fnameescape(path_to_open))
			end,
			['<C-t>'] = { 'actions.select', opts = { tab = true } },
			['<C-p>'] = 'actions.preview',
			['<C-c>'] = { 'actions.close', mode = 'n' },
			['<C-r>'] = 'actions.refresh',
			['-'] = { 'actions.parent', mode = 'n' },
			['_'] = { 'actions.open_cwd', mode = 'n' },
		},
		use_default_keymaps = false,
		view_options = {
			show_hidden = true,
			winbar = '%!v:lua.get_oil_winbar()',
			signcolumn = 'yes',
		},
	},
	dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
	lazy = false,
}
