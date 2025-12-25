local M = {}

function M.setup()
  ---@type integer
  local bufnr = vim.api.nvim_get_current_buf()
  ---@type function
  local map = vim.keymap.set

  map(
    'n',
    '<F4>',
    function() vim.cmd.RustLsp('codeAction') end,
    { silent = true, buffer = bufnr, desc = 'Rust Hover Info' }
  )
  map(
    'n',
    'K',
    function() vim.cmd.RustLsp { 'hover', 'actions' } end,
    { silent = true, buffer = bufnr, desc = 'Rust Code Actions' }
  )
end

return M
