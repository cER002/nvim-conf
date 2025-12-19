vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then return end

    local map = vim.keymap.set
    local opts = { buffer = event.buf }
    local builtin = require('telescope.builtin')
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gd', builtin.lsp_definitions, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gi', builtin.lsp_implementations, opts)
    map('n', 'gR', builtin.lsp_references, opts)
    map('n', 'gs', builtin.lsp_workspace_symbols, opts)
    map('n', '<F2>', vim.lsp.buf.rename, opts)
    map('n', '<F4>', vim.lsp.buf.code_action, opts)
    map('n', 'g]', '<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>', opts)
    map('n', 'g[', '<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>', opts)
  end,
})
