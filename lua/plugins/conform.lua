return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      css = { 'prettier' },
      -- java = { 'google_java_format' }, redundant with JDTLS formatting
      python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
      bash = { 'beautysh' },
      sh = { 'beautysh' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      toml = { 'taplo' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      arduino = { 'clang-format' },
    },
    -- formatters = {
    --   google_java_format = {
    --     command = 'google-java-format',
    --     args = { '-' },
    --     stdin = true,
    --   },
    -- },
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
