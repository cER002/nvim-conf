return {
	{ "neovim/nvim-lspconfig" },
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"pyright",
				"jdtls",
				"lua_ls",
				"stylua",
				"rust_analyzer",
				"hyprls",
				"bash-language-server",
			},
			automatic_enable = {
				exclude = {
					"jdtls",
				},
			},
		},
		config = function()
			vim.diagnostic.config({
				severity_sort = true,
				virtual_text = {
					virt_text_pos = "eol",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" }, { "nvim-dap-ui" } },
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {
			file_types = { "markdown", "copilot-chat" },
			completions = { lsp = { enabled = true } },
		},
	},
}
