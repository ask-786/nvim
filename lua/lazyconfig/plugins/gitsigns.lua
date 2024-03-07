local config = function()
	require('gitsigns').setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map('n', '<leader>g[', function()
				if vim.wo.diff then
					return '<leader>g['
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return '<Ignore>'
			end, { expr = true, desc = 'Gitsigns Next Hunk' })

			map('n', '<leader>g]', function()
				if vim.wo.diff then
					return '<leader>g]'
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return '<Ignore>'
			end, { expr = true, desc = 'Gitsigns Prev Hunk' })

			map('n', '<leader>gS', gs.stage_hunk, { desc = 'Gitsigns Stage Hunk' })
			map('n', '<leader>gu', gs.reset_hunk, { desc = 'Gitsigns Reset Hunk' })
			map('v', '<leader>gS', function()
				gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end, { desc = 'Gitsigns Stage Hunk' })
			map('v', '<leader>gu', function()
				gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
			end, { desc = 'Gitsigns Reset Hunk' })
			map('n', '<leader>gU', gs.undo_stage_hunk, { desc = 'Gitsigns Undo Stage' })
			map('n', '<leader>gR', gs.reset_buffer, { desc = 'Gitsigns Reset Buffer' })
			map('n', '<leader>gk', gs.preview_hunk, { desc = 'Gitsigns Preivew Hunk' })
			map('n', '<leader>gb', function()
				gs.blame_line({ full = true })
			end, { desc = 'Gitsigns Blame Line' })
			map('n', '<leader>gd', gs.diffthis, { desc = 'Gitsigns Diff File' })
			map('n', '<leader>gD', function()
				gs.diffthis('~')
			end, { desc = 'Gitsigns Diff File' })
			map('n', '<leader>td', gs.toggle_deleted, { desc = 'Gitsigns Diff File' })
		end,

		signs = {
			add = { text = '│' },
			change = { text = '│' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
			untracked = { text = '┆' },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol',
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = 'rounded',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
	})
end

return {
	'lewis6991/gitsigns.nvim',
	config = config,
}
