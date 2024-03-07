local M = {}

local function allow_format(servers)
	return function(client)
		return vim.tbl_contains(servers, client.name)
	end
end

M.on_attach = function(_, bufnr)
	local map = function(mode, keys, action, desc)
		local opts = { buffer = bufnr, remap = false, desc = desc }
		vim.keymap.set(mode, keys, action, opts)
	end

	map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
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

return M
