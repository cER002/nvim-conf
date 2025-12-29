local schemas = require('schemastore').json.schemas()

---@type vim.lsp.Config
local config = {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}

return config
