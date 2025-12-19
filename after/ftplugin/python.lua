vim.lsp.config('ruff', {
  -- init_options = {
  --   settings = {},
  -- },
})

-- disable stuff for ruff
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      autoImportCompletions = true,
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'standard',
        diagnosticSeverityOverrides = {
          reportUnusedImport = 'none',
          reportUnusedVariable = 'none',
          reportUnusedFunction = 'none',
        },
      },
    },
  },
})

vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
