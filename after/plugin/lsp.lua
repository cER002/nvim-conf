vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
    client.server_capabilities.semanticTokensProvider = nil

    local map = vim.keymap.set
    local builtin = require('telescope.builtin')
    map('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover Info' })
    map('n', 'gd', builtin.lsp_definitions, { buffer = event.buf, desc = 'LSP Definitions' })
    map('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = 'Go to Declaration' })
    map('n', 'gi', builtin.lsp_implementations, { buffer = event.buf, desc = 'LSP Implementations' })
    map('n', 'gR', builtin.lsp_references, { buffer = event.buf, desc = 'LSP References' })
    map('n', 'gs', builtin.lsp_workspace_symbols, { buffer = event.buf, desc = 'LSP Workspace Symbols' })
    map('n', 'gI', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Enable Inlay Hints' })
    map('n', '<F2>', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP Buffer Rename' })
    map('n', '<F4>', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP Code Action' })
    map('n', 'g]', function() vim.diagnostic.jump { count = 1, float = true } end, { buffer = event.buf })
    map('n', 'g[', function() vim.diagnostic.jump { count = -1, float = true } end, { buffer = event.buf })
  end,
})
