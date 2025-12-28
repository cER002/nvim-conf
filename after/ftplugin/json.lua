local schemas = require('schemastore').json.schemas()

vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
})
vim.lsp.enable('jsonls')
