local lsp_zero = require('lsp-zero');
local lsp_config = require('lspconfig');
local null_ls = require('null-ls');

lsp_zero.on_attach(function (_, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr });
end);

local function allow_format(servers)
	return function (client) return vim.tbl_contains(servers, client.name); end;
end;

require('lspconfig.ui.windows').default_options.border = 'rounded';
require('mason').setup({
	ui = {
		border = 'rounded',
	},
});

require('mason-lspconfig').setup({
	ensure_installed = { 'tsserver', 'lua_ls' },
	handlers = { lsp_zero.default_setup, },
});

local on_attach = function (_, bufnr)
	local opts = { buffer = bufnr, remap = false };
	vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition(); end, opts);
	vim.keymap.set('n', 'K', function () vim.lsp.buf.hover(); end, opts);
	vim.keymap.set('n', '<leader>e', function () vim.diagnostic.open_float(); end,
		opts);
	vim.keymap.set('n', '[d', function () vim.diagnostic.goto_next(); end, opts);
	vim.keymap.set('n', ']d', function () vim.diagnostic.goto_prev(); end, opts);
	vim.keymap.set('n', '<leader>ca', function () vim.lsp.buf.code_action(); end,
		opts);
	vim.keymap.set('n', '<leader>rn', function () vim.lsp.buf.rename(); end, opts);
	vim.keymap.set('i', '<C-a>', function () vim.lsp.buf.signature_help(); end,
		opts);
	vim.keymap.set('n', '<leader>dg', function () vim.diagnostic.setqflist(); end,
		opts);
	vim.keymap.set({ 'n', 'x' }, '<leader>ff', function ()
		vim.lsp.buf.format({
			async = false,
			timeout_ms = 10000,
			filter = allow_format({
				'lua_ls',
				'rust_analyzer',
				'null-ls',
				'dartls',
				'gopls',
				'clangd',
				'jsonls',
			})
		});
	end, opts);
end;

lsp_zero.on_attach(on_attach);

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
		}
	},
	docs = {
		description = [[
            https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec

            Language server for dart.
        ]],
		default_config = { root_dir = [[root_pattern("pubspec.yaml")]], },
	},
});

lsp_config.gopls.setup({
	on_attach = on_attach,
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_dir = lsp_config.util.root_pattern('go.work', 'go.mod', '.git'),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = { unusedparams = true, }
		}
	}
});

lsp_config.rust_analyzer.setup({
	on_attach = on_attach,
	cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
});

lsp_config.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				-- Tells lua_ls where to find all the Lua files that you have loaded
				-- for your neovim configuration.
				library = {
					'${3rd}/luv/library',
					unpack(vim.api.nvim_get_runtime_file('', true)),
				},
				-- If lua_ls is really slow on your computer, you can try this instead:
				-- library = { vim.env.VIMRUNTIME },
			},
			completion = {
				callSnippet = 'Replace',
			},
		},
	}
});

lsp_config.quick_lint_js.setup({});

lsp_config.pyright.setup({
	on_attach = on_attach,
})

lsp_zero.setup();

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.shfmt
	},
});