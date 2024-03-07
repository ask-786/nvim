local M = {}

local function allow_format(servers)
	return function(client)
		return vim.tbl_contains(servers, client.name)
	end
end

M.onattach = function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set('n', 'gd', function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set('n', 'K', function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set('n', '<leader>e', function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set('n', '<leader>ca', function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set('n', '<leader>rn', function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set('i', '<C-a>', function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set('n', '<leader>dg', function()
		vim.diagnostic.setqflist()
	end, opts)
	vim.keymap.set({ 'n', 'x' }, '<leader>ff', function()
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
	end, opts)
end

return M
