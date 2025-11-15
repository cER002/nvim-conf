return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "python", "css", "yaml", "java", "bash", "html", "markdown" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
