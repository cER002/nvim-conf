local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

---@type vim.lsp.Config
return {
  capabilities = capabilities,
}
