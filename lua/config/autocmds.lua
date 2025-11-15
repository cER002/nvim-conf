-- Open images with feh
vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
	pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.bmp", "*.webp", "*.svg" },
	callback = function()
		vim.fn.jobstart({ "feh", vim.fn.expand("<afile>:p") }, { detach = true })
		vim.cmd("bdelete")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only")
		vim.bo.buflisted = true
	end,
})
