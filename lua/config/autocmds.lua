-- Open images with feh
vim.api.nvim_create_autocmd({ 'BufReadCmd' }, {
  pattern = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.bmp', '*.webp', '*.svg' },
  callback = function()
    vim.fn.jobstart({ 'feh', vim.fn.expand('<afile>:p') }, { detach = true })
    vim.cmd('bdelete')
  end,
})

-- focus on help document
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd('only')
    vim.bo.buflisted = true
  end,
})

-- formatting on write, conform.nvim must be loaded before
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = lint_augroup,
  callback = function(args) require('conform').format { bufnr = args.buf } end,
})
