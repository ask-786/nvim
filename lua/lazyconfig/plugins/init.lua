return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'LunarVim/bigfile.nvim' },
	{ 'tpope/vim-sleuth' },
	{ 'echasnovski/mini.ai', version = '*' },
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	},
	{
		'ask-786/Comment.nvim',
		event = 'BufEnter',
		opts = {},
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'ask-786/time-calculator.nvim',
		opts = {},
	},
}
