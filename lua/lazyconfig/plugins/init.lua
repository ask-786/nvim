return {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'windwp/nvim-autopairs',
		event = 'BufEnter',
		config = function()
			require('nvim-autopairs').setup({})
		end,
	},
	{
		'numToStr/Comment.nvim',
		event = 'BufEnter',
		config = function()
			require('Comment').setup()
		end,
	},
	{ 'tpope/vim-sleuth' },

	{ -- Mini plugins
		'echasnovski/mini.surround',
		version = '*',
		config = function()
			require('mini.surround').setup()
		end,
	},

	{ -- Telescope Extensions
		'nvim-telescope/telescope-ui-select.nvim',
		dependencies = 'nvim-telescope/telescope.nvim',
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		dependencies = 'nvim-telescope/telescope.nvim',
	},

	-- CMP Plugins
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
}
