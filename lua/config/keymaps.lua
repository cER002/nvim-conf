local map = vim.keymap.set
map(
  'n',
  'gI',
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  { desc = 'Enable Inlay Hints' }
)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
