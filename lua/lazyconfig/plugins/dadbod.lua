return {
	'kristijanhusak/vim-dadbod-ui',
	enabled = false,
	dependencies = {
		{ 'tpope/vim-dadbod', lazy = true },
		{
			'kristijanhusak/vim-dadbod-completion',
			ft = { 'sql', 'mysql', 'plsql' },
			lazy = true,
		},
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		---@diagnostic disable-next-line: inject-field
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
