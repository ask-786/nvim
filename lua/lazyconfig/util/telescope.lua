local M = {}

M.live_multigrep = function(opts)
	local pickers = require('telescope.pickers')
	local finders = require('telescope.finders')
	local make_entry = require('telescope.make_entry')
	local conf = require('telescope.config').values

	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == '' then
				return nil
			end

			local pieces = vim.split(prompt, '  g:')

			if not pieces[1] or pieces[1] == '' then
				return nil
			end

			local args = { 'rg' }
			if pieces[1] then
				table.insert(args, '-e')
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, '-g')
				table.insert(args, pieces[2])
			end

			return vim
				.iter({
					args,
					{
						'-U',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
					},
				})
				:flatten()
				:totable()
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = 'Multi Grep',
			hidden = true,
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require('telescope.sorters').empty(),
		})
		:find()
end

M.get_visual_selection_text = function()
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

return M
