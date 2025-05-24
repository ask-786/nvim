local map_with_desc = require('lazyconfig.util').map_with_desc

local M = {}

---On Attach Function For LSPs
---@param client vim.lsp.Client
---@param bufnr number
M.on_attach = function(client, bufnr)
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
	local original_open_floating_preview = vim.lsp.util.open_floating_preview

	vim.lsp.config('*', {
		on_attach = M.on_attach,
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
	})

	---@diagnostic disable-next-line: duplicate-set-field
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or 'rounded'
		return original_open_floating_preview(contents, syntax, opts, ...)
	end

	vim.lsp.config('angularls', {
		on_attach = M.on_attach,
		settings = {
			angular = { forceStrictTemplates = true },
		},
	})

	vim.lsp.enable({ 'dartls' })
end

return M
