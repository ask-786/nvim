local M = {}

local function allow_format(servers)
	return function(client)
		return vim.tbl_contains(servers, client.name)
	end
end

---On Attach Function For LSPs
local function on_attach(_, bufnr)
	local map = function(mode, keys, action, desc)
		local opts = { buffer = bufnr, remap = false, desc = desc }
		vim.keymap.set(mode, keys, action, opts)
	end

	map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
	map('n', 'gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
	map('n', 'K', vim.lsp.buf.hover, 'Lsp Hover')
	map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	map('n', '<leader>rn', vim.lsp.buf.rename, '[R]ename')
	map('i', '<C-a>', vim.lsp.buf.signature_help, 'Signature Help')
	map({ 'n', 'x' }, '<leader>ff', function()
		vim.lsp.buf.format({
			async = false,
			timeout_ms = 10000,
			filter = allow_format({
				'rust_analyzer',
				'null-ls',
				'dartls',
				'gopls',
				'clangd',
				'jsonls',
			}),
		})
	end, '[F]ormat [F]ile')
end

M.lsp_config = function()
	local lsp_zero = require('lsp-zero')
	lsp_zero.extend_lspconfig()
	lsp_zero.on_attach(on_attach)

	local lsp_config = require('lspconfig')
	require('lspconfig.ui.windows').default_options.border = 'rounded'

	lsp_config.dartls.setup({
		on_attach = on_attach,
		init_options = {
			onlyAnalyzeProjectsWithOpenFiles = false,
		},
		settings = {
			dart = {
				analysisExcludedFolders = {
					vim.fn.expand('$HOME/AppData/Local/Pub/Cache'),
					vim.fn.expand('$HOME/.pub-cache/'),
					vim.fn.expand('$HOME/dev/flutter/'),
				},
				updateImportsOnRename = true,
			},
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

M.mason_lsp_config = function()
	local lsp_zero = require('lsp-zero')
	lsp_zero.extend_lspconfig()

	require('mason-lspconfig').setup({
		ensure_installed = { 'tsserver', 'lua_ls' },
		handlers = { lsp_zero.default_setup },
	})
end

M.null_ls_config = function()
	local null_ls = require('null-ls')

	null_ls.setup({
		on_attach = on_attach,
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.google_java_format,
			null_ls.builtins.formatting.pretty_php,
		},
	})
end

return M
