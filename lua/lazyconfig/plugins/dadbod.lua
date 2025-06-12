return {
	'kristijanhusak/vim-dadbod-ui',
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
		vim.g.db_ui_auto_execute_table_helpers = 1
	end,
}
