local map_with_desc = require('lazyconfig.util').map_with_desc

local M = {}

---On Attach Function For LSPs
local function on_attach(_, bufnr)
	local map = function(mode, keys, action, desc)
		local opts = { buffer = bufnr, remap = false }
		map_with_desc(mode, keys, action, desc, opts)
	end

	map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
	map('n', 'gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
	map('n', 'K', vim.lsp.buf.hover, 'Lsp Hover')
	map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	map('n', '<leader>rn', vim.lsp.buf.rename, '[R]ename')
	map('i', '<C-a>', vim.lsp.buf.signature_help, 'Signature Help')
end

M.lsp_highlight = function(event)
	-- When you move your cursor, the highlights will be cleared (the second autocommand).
	local client = vim.lsp.get_client_by_id(event.data.client_id)

	if not client or not client.server_capabilities.documentHighlightProvider then
		return
	end

	local highlight_augroup =
		vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

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
		group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
		callback = function(event2)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({
				group = 'lsp-highlight',
				buffer = event2.buf,
			})
		end,
	})
end

M.lsp_config = function()
	local lsp_config = require('lspconfig')
	local mason_lsp_config = require('mason-lspconfig')

	local original_open_floating_preview = vim.lsp.util.open_floating_preview

	---@diagnostic disable-next-line: duplicate-set-field
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or 'single'
		return original_open_floating_preview(contents, syntax, opts, ...)
	end

	local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	mason_lsp_config.setup({
		automatic_installation = false,
		ensure_installed = { 'ts_ls', 'lua_ls' },
		handlers = {
			function(server_name)
				local server = lsp_config[server_name] or {}
				server.on_attach = on_attach
				server.capabilities = capabilities
				lsp_config[server_name].setup(server)
			end,
		},
	})

	lsp_config.dartls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
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
		},
	})
end

return M
