---@type vim.lsp.Config
return {
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
}
