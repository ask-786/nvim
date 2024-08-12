local map_with_desc = require('lazyconfig.helpers').map_with_desc

local on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, desc)
		map_with_desc(mode, l, r, 'Gitsigns ' .. desc, { buffer = bufnr })
	end

	map('n', '<leader>g[', function()
		if vim.wo.diff then
			vim.cmd.normal({ '<leader>g[', bang = true })
		else
			gs.nav_hunk('next')
		end
	end, 'Next Hunk')

	map('n', '<leader>g]', function()
		if vim.wo.diff then
			vim.cmd.normal({ '<leader>g]', bang = true })
		else
			gs.nav_hunk('prev')
		end
	end, 'Prev Hunk')

	-- stylua: ignore start
	map('n', '<leader>gS', gs.stage_hunk, 'Stage Hunk')
	map('n', '<leader>gu', gs.reset_hunk, 'Reset Hunk')
	map('n', '<leader>gU', gs.undo_stage_hunk, 'Undo Stage')
	map('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
	map('n', '<leader>gk', gs.preview_hunk, 'Preivew Hunk')
	map('n', '<leader>gd', gs.diffthis, 'Diff File')
	map('n', '<leader>td', gs.toggle_deleted, 'Diff File')
	map('v', '<leader>gS', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage Hunk')
	map('v', '<leader>gu', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset Hunk')
	map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame Line')
	map('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff File')
	-- stylua: ignore end
end

local config = function()
	require('gitsigns').setup({
		on_attach = on_attach,
		current_line_blame = true,
		current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
		preview_config = {
			border = 'rounded',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
	})
end

return {
	'lewis6991/gitsigns.nvim',
	config = config,
}
