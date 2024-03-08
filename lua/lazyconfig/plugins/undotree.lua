local keys = { { '<leader>u', vim.cmd.UndotreeToggle, 'n' } }
return {
	'mbbill/undotree',
    lazy = true,
	keys = keys,
}
