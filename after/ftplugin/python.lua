vim.lsp.config('ruff', {})

-- disable stuff for ruff
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      autoImportCompletions = true,
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'off',
        ignore = { '*' },
        diagnosticSeverityOverrides = {
          reportUnusedImport = 'none',
          reportUnusedVariable = 'none',
          reportUnusedFunction = 'none',
        },
      },
      python = {
        pythonPath = '.venv/bin/python', -- deafult setting
      },
    },
  },
})

vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
