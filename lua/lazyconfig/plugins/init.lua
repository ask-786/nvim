return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'LunarVim/bigfile.nvim' },
	{ 'tpope/vim-sleuth' },
	{ 'echasnovski/mini.ai', version = '*', opts = {} },
	{ 'ask-786/time-calculator.nvim', opts = {} },
	{ 'ask-786/Comment.nvim', event = 'BufEnter', opts = {} },
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {},
	},
}
