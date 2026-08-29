return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" },
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Global LSP attach keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					local keymap = vim.keymap.set

					opts.desc = "Go to definition"
					keymap("n", "gd", vim.lsp.buf.definition, opts)

					opts.desc = "Hover documentation"
					keymap("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Code action"
					keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					opts.desc = "Rename symbol"
					keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

					opts.desc = "Go to references"
					keymap("n", "gr", vim.lsp.buf.references, opts)

					opts.desc = "Go to declaration"
					keymap("n", "gD", vim.lsp.buf.declaration, opts)

					opts.desc = "Go to implementation"
					keymap("n", "gi", vim.lsp.buf.implementation, opts)

					opts.desc = "Show line diagnostics"
					keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

					opts.desc = "Previous diagnostic"
					keymap("n", "[d", vim.diagnostic.goto_prev, opts)

					opts.desc = "Next diagnostic"
					keymap("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})

			-- Configure servers using standard vim.lsp.config & vim.lsp.enable (Nvim 0.11+)
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("eslint", {
				capabilities = capabilities,
			})

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
			})

			vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "tailwindcss" })
		end,
	},
}
