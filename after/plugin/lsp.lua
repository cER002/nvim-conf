vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then
			return
		end
		-- Disable semantic highlights
		client.server_capabilities.semanticTokensProvider = nil

		local opts = { buffer = event.buf }
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "gr", builtin.lsp_references, opts)
		vim.keymap.set("n", "gs", builtin.lsp_workspace_symbols, opts)
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "x" }, "=", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>", opts)
		vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>", opts)
	end,
})

vim.lsp.config("ruff", {
	init_options = {
		settings = {},
	},
})

vim.lsp.config("bashls", {
	on_attach = function(client) end,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
})

vim.lsp.config("lua_ls", {
	on_attach = function(client) end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("stylua", {})

vim.lsp.config("hyprls", {
	on_attach = function(client) end,
})

vim.lsp.enable("hyprls")
vim.lsp.enable("bashls")
vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")
vim.lsp.enable("stylua")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		require("jdtls.jdtls_setup").setup()
	end,
})
