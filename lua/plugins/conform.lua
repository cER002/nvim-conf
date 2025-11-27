return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				css = { "prettier" },
				java = { "google_java_format" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				bash = { "beautysh" },
				json = { "prettier" },
				jsonc = { "prettier" },
			},
			formatters = {
				google_java_format = {
					command = "google-java-format",
					args = { "-" },
					stdin = true,
				},
				black = {
					command = "black",
					args = { "-" },
					stdin = true,
				},
				beautysh = {
					command = "beautysh",
					args = { "-" },
					stdin = true,
				},
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
