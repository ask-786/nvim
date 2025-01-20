local map = require('lazyconfig.util').map_with_desc
local live_grep = require('lazyconfig.util.telescope').live_multigrep

local get_visual_selection_text = function()
	local _, srow, scol = unpack(vim.fn.getpos('v'))
	local _, erow, ecol = unpack(vim.fn.getpos('.'))

	-- Visual line mode
	if vim.fn.mode() == 'V' then
		if srow > erow then
			return table.concat(
				vim.api.nvim_buf_get_lines(0, erow - 1, srow, true),
				'\n'
			)
		end

		return table.concat(
			vim.api.nvim_buf_get_lines(0, srow - 1, erow, true),
			'\n'
		)
	end

	-- Regular visual mode
	if vim.fn.mode() == 'v' then
		if srow < erow or (srow == erow and scol <= ecol) then
			return table.concat(
				vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {}),
				'\n'
			)
		end

		return table.concat(
			vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {}),
			'\n'
		)
	end
end

local config = function()
	local builtin = require('telescope.builtin')
	local telescope = require('telescope')

	---@param mode 'g' | 'n' | 'v'
	---@return fun():nil
	local grep_func = function(mode)
		return function()
			local search_string

			if mode == 'n' then
				search_string = vim.fn.expand('<cword>')
			end

			if mode == 'g' then
				search_string = vim.fn.input('Grep > ')
			end

			if mode == 'v' then
				search_string = get_visual_selection_text()
			end

			if not search_string or search_string == '' then
				vim.notify('Can\'t search nil value')
				return
			end

			builtin.grep_string({ search = search_string })
		end
	end

	map('n', '<leader>pf', builtin.find_files, '[P]roject [F]iles')
	map('n', '<leader>pg', live_grep, '[P]roject [G]rep')
	map('n', '<leader>pa', builtin.oldfiles, '[P]roject Old Files')
	map('n', '<leader>pr', builtin.lsp_references, '[P]roject [R]eferences')
	map('n', '<leader>pe', builtin.diagnostics, '[P]roject Diagnostics')
	map('n', '<leader>pt', builtin.resume, '[P]roject Recent [T]elescope')
	map('n', '<leader>pb', builtin.buffers, '[P]roject [B]uffers')
	map('n', '<leader>ph', builtin.help_tags, '[P]roject [B]uffers')
	map('n', '<leader>ps', grep_func('g'), '[P]roject [S]earch')
	map('n', '<leader>pc', grep_func('n'), '[P]roject Search [C]urrent')
	map('v', '<leader>pc', grep_func('v'), '[P]roject Search [C]urrent')
	map('n', '<C-g>', builtin.git_files, 'Git Files')

	telescope.setup({
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown({}),
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = 'smart_case',
			},
		},
		defaults = {
			file_ignore_patterns = { 'node_modules', '.git/' },
			mappings = {
				i = {
					['<M-j>'] = 'results_scrolling_left',
					['<M-k>'] = 'results_scrolling_right',
				},
				n = {
					['<M-j>'] = 'results_scrolling_left',
					['<M-k>'] = 'results_scrolling_right',
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	})

	pcall(telescope.load_extension, 'fzf')
	pcall(telescope.load_extension, 'ui-select')
end

return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			'nvim-telescope/telescope-ui-select.nvim',
		},
		config = config,
	},
}
