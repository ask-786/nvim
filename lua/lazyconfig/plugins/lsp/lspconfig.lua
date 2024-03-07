local on_attach = require('lazyconfig.plugins.lsp.helpers').onattach
local config = function()

	local lsp_zero = require('lsp-zero')
	lsp_zero.extend_lspconfig()
    lsp_zero.on_attach(on_attach)

	local lsp_config = require('lspconfig')
	require('lspconfig.ui.windows').default_options.border = 'rounded'

	lsp_config.dartls.setup({
		on_attach = on_attach,
		root_dir = lsp_config.util.root_pattern('pubspec.yaml'),
		filetypes = { 'dart' },
		init_options = {
			onlyAnalyzeProjectsWithOpenFiles = false,
			suggestFromUnimportedLibraries = true,
			closingLabels = true,
			outline = true,
			fluttreOutline = true,
		},
		settings = {
			dart = {
				analysisExcludedFolders = {
					vim.fn.expand('$HOME/AppData/Local/Pub/Cache'),
					vim.fn.expand('$HOME/.pub-cache/'),
					vim.fn.expand('$HOME/dev/flutter/'),
				},
				updateImportsOnRename = true,
				completeFunctionCalls = true,
				showTodos = true,
			},
		},
		docs = {
			description = [[
            https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec

            Language server for dart.
        ]],
			default_config = { root_dir = [[root_pattern("pubspec.yaml")]] },
		},
	})

	lsp_config.gopls.setup({
		on_attach = on_attach,
		cmd = { 'gopls' },
		filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
		root_dir = lsp_config.util.root_pattern('go.work', 'go.mod', '.git'),
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = { unusedparams = true },
			},
		},
	})

	lsp_config.rust_analyzer.setup({
		on_attach = on_attach,
		cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
	})

	lsp_config.lua_ls.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT' },
				workspace = {
					checkThirdParty = false,
					library = {
						'${3rd}/luv/library',
						unpack(vim.api.nvim_get_runtime_file('', true)),
					},
				},
				completion = {
					callSnippet = 'Replace',
				},
			},
		},
	})

	lsp_config.quick_lint_js.setup({})

	lsp_config.pyright.setup({
		on_attach = on_attach,
	})
end

return {
	'neovim/nvim-lspconfig',
	cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'williamboman/mason-lspconfig.nvim' },
	},
	config = config,
}
