return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	opts = {},
	config = function()
		local dap = require("dap");
		local dapui = require("dapui");
		local dapvirtual = require("nvim-dap-virtual-text");

		---@diagnostic disable-next-line: missing-parameter
		dapvirtual.setup()
		dapui.setup()

		dap.adapters.chrome = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/personal/vscode-chrome-debug/out/src/chromeDebug.js" }
		}


		dap.configurations.javascript = {
			{
				type = "chrome",
				request = "attach",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}"
			},
			{
				type = "chrome",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				runtimeExecutable = "/usr/bin/brave-browser-stable",
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}"
			}
		}

		dap.configurations.typescript = {
			{
				type = "chrome",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				runtimeExecutable = "/usr/bin/brave-browser-stable",
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}"
			},
			{
				type = "chrome",
				request = "attach",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}"
			},
		}

		vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
		vim.keymap.set('n', '<F5>', dap.continue)
		vim.keymap.set('n', '<F10>', dap.step_over)
		vim.keymap.set('n', '<F11>', dap.step_into)
		vim.keymap.set('n', '<F12>', dap.step_out)
		vim.keymap.set('n', '<leader>dbc', dapui.close)
		vim.keymap.set('n', '<leader>dbo', dapui.open)
		vim.keymap.set('n', '<leader>dbf', dapui.float_element)

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end
}
