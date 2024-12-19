---@diagnostic disable: duplicate-set-field

local M = {}

local function filter_without(servers, bufnr)
	return function(client)
		if vim.tbl_contains(servers, client.name) then return false end

		if client.name == 'null-ls' then return true end

		if client.supports_method('textDocument/formatting', bufnr) then return true end
	end
end

---@param mode string | table
---@param lhs string
---@param rhs function | string
---@param desc string
---@param extra_opts? table
M.map_with_desc = function(mode, lhs, rhs, desc, extra_opts)
	local opts = { desc = desc }

	if extra_opts then
		for key, value in pairs(extra_opts) do
			opts[key] = value
		end
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

---On Attach Function For LSPs
local function on_attach(_, bufnr)
	local map = function(mode, keys, action, desc)
		local opts = { buffer = bufnr, remap = false }
		M.map_with_desc(mode, keys, action, desc, opts)
	end

	map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
	map('n', 'gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
	map('n', 'K', vim.lsp.buf.hover, 'Lsp Hover')
	map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	map('n', '<leader>rn', vim.lsp.buf.rename, '[R]ename')
	map('i', '<C-a>', vim.lsp.buf.signature_help, 'Signature Help')
	map({ 'n', 'x' }, '<leader>ff', function()
		vim.lsp.buf.format({
			bufnr = bufnr,
			async = false,
			timeout_ms = 5000,
			filter = filter_without({ 'ts_ls' }, bufnr),
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
	local lsp_config = require('lspconfig')
	local mason_lsp_config = require('mason-lspconfig')
	local blink = require('blink.cmp')

	local original_open_floating_preview = vim.lsp.util.open_floating_preview

	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or 'rounded'
		return original_open_floating_preview(contents, syntax, opts, ...)
	end

	local capabilities = blink.get_lsp_capabilities(nil, true)

	mason_lsp_config.setup({
		automatic_installation = false,
		ensure_installed = { 'ts_ls', 'lua_ls' },
		handlers = {
			function(server_name)
				lsp_config[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities
				})
			end,
		},
	})

	lsp_config.dartls.setup({
		on_attach = on_attach,
		capabilities = capabilities
	})

	lsp_config.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				},
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
		capabilities = capabilities,
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

	lsp_config.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
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
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.google_java_format,
			null_ls.builtins.formatting.pretty_php,
		},
	})
end

return M
