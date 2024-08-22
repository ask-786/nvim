return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	},
	{
		'numToStr/Comment.nvim',
		event = 'BufEnter',
		opts = {},
	},
	{ 'tpope/vim-sleuth' },
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {},
	},
}
