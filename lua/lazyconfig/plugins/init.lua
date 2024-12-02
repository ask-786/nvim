return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
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
	{ 'tpope/vim-sleuth' },
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter',
	},
}
