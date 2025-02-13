local M = {}

M.select_provider_with_chain_by_default = function()
	local ftMap = {
		vim = 'indent',
		python = { 'indent' },
		htmlangular = { 'treesitter' },
		git = '',
	}

	---@param bufnr number
	---@return Promise
	local function customize_selector(bufnr)
		local function handle_fallback_exception(err, provider_name)
			if type(err) == 'string' and err:match('UfoFallbackException') then
				return require('ufo').getFolds(bufnr, provider_name)
			else
				return require('promise').reject(err)
			end
		end

		return require('ufo')
			.getFolds(bufnr, 'lsp')
			:catch(function(err)
				return handle_fallback_exception(err, 'treesitter')
			end)
			:catch(function(err)
				return handle_fallback_exception(err, 'indent')
			end)
	end

	return function(_, filetype)
		return ftMap[filetype] or customize_selector
	end
end

M.customize_fold_text_handler = function(
	virtText,
	lnum,
	endLnum,
	width,
	truncate
)
	local new_virt_text = {}
	local suffix = (' 󰁂 %d '):format(endLnum - lnum)
	local suf_width = vim.fn.strdisplaywidth(suffix)
	local target_width = width - suf_width
	local cur_width = 0

	for _, chunk in ipairs(virtText) do
		local chunk_text = chunk[1]
		local chunk_width = vim.fn.strdisplaywidth(chunk_text)

		if target_width > cur_width + chunk_width then
			table.insert(new_virt_text, chunk)
		else
			chunk_text = truncate(chunk_text, target_width - cur_width)
			local hl_group = chunk[2]
			table.insert(new_virt_text, { chunk_text, hl_group })
			chunk_width = vim.fn.strdisplaywidth(chunk_text)

			-- str width returned from truncate() may less than 2nd argument, need padding
			if cur_width + chunk_width < target_width then
				suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
			end
			break
		end

		cur_width = cur_width + chunk_width
	end

	table.insert(new_virt_text, { suffix, 'MoreMsg' })
	return new_virt_text
end

return M
