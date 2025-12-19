vim.lsp.config('qmlls', {
  root_markers = { '.git', 'shell.qml' },
})
vim.lsp.enable('qmlls')
