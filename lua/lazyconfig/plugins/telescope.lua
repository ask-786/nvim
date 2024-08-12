local map = require('lazyconfig.helpers').map_with_desc

local config = function()
	local builtin = require('telescope.builtin')
	local telescope = require('telescope')

	---@param current? boolean
	---@return function
	local grep_func = function(current)
		return function()
			local search_string = vim.fn.expand('<cword>')

			if not current then
				search_string = vim.fn.input('Grep > ')
			end

			builtin.grep_string({ search = search_string })
		end
	end

	--stylua: ignore start
	map('n', '<leader>pf', builtin.find_files,  '[P]roject [F]iles' )
	map('n', '<leader>pg', builtin.live_grep,  '[P]roject [G]rep' )
	map('n', '<leader>pa', builtin.oldfiles,  '[P]roject Old Files' )
	map('n', '<leader>pr', builtin.lsp_references,  '[P]roject [R]eferences' )
	map('n', '<leader>pe', builtin.diagnostics,  '[P]roject Diagnostics' )
	map('n', '<leader>pt', builtin.resume,  '[P]roject Recent [T]elescope' )
	map('n', '<leader>ps', grep_func(),  '[P]roject [S]earch' )
	map('n', '<leader>pc', grep_func(true),  '[P]roject Search [C]urrent' )
	map('n', '<C-g>', builtin.git_files,  'Git Files' )
	--stylua: ignore end

	telescope.setup({
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown({
					-- even more opts
				}),
			},
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
			},
		},
		defaults = {
			file_ignore_patterns = {
				'node_modules',
				'.git/',
			},
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
				-- Show hidden files
				hidden = true,
			},
		},
	})

	pcall(telescope.load_extension, 'fzf')
	pcall(telescope.load_extension, 'ui-select')
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	config = config,
}
