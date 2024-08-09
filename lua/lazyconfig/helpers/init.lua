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

M.lsp_highlight = function(event)
	-- When you move your cursor, the highlights will be cleared (the second autocommand).
	local client = vim.lsp.get_client_by_id(event.data.client_id)

	if not client or not client.server_capabilities.documentHighlightProvider then
		return
	end

	local highlight_augroup =
		vim.api.nvim_create_augroup('ask-lsp-highlight', { clear = false })

	vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
		buffer = event.buf,
		group = highlight_augroup,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
		buffer = event.buf,
		group = highlight_augroup,
		callback = vim.lsp.buf.clear_references,
	})

	vim.api.nvim_create_autocmd('LspDetach', {
		group = vim.api.nvim_create_augroup('ask-lsp-detach', { clear = true }),
		callback = function(event2)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({
				group = 'ask-lsp-highlight',
				buffer = event2.buf,
			})
		end,
	})
end

M.lsp_config = function()
	local lsp_zero = require('lsp-zero')
	local lsp_config = require('lspconfig')
	local mason_lsp_config = require('mason-lspconfig')

	lsp_zero.extend_lspconfig()
	lsp_zero.on_attach(on_attach)

	mason_lsp_config.setup({
		ensure_installed = { 'tsserver', 'lua_ls' },
		handlers = { lsp_zero.default_setup },
	})

	lsp_config.dartls.setup({
		on_attach = on_attach,
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

	lsp_config.angularls.setup({
		on_attach = on_attach,
		settings = {
			angular = {
				forceStrictTemplates = true,
				suggest = {
					includeAutomaticOptionalChainCompletions = true,
					includeCompletionsWithSnippetText = true,
				},
			},
		},
	})

	lsp_config.tsserver.setup({
		on_attach = on_attach,
		settings = {
			completions = {
				completeFunctionCalls = true,
			},
			implicitProjectConfiguration = {
				checkJs = true,
			},
		},
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
