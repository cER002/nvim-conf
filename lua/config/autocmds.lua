-- focus on help document
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd('only')
    vim.bo.buflisted = true
  end,
})

-- Aggressive linting
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  pattern = '*',
  callback = function() require('lint').try_lint() end,
})

-- Refresh CodeLens
vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
  callback = function() vim.lsp.codelens.refresh { bufnr = 0 } end,
})

-- Change buf filetype to systemd for systemd-lsp
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.service',
    '*.socket',
    '*.timer',
    '*.mount',
    '*.automount',
    '*.swap',
    '*.target',
    '*.path',
    '*.slice',
    '*.scope',
    '*.device',
    '*.container',
    '*.volume',
    '*.network',
    '*.kube',
    '*.pod',
    '*.build',
    '*.image',
  },
  callback = function() vim.bo.filetype = 'systemd' end,
})
