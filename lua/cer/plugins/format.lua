return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  --- @module "conform"
  --- @type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- css = { 'prettier' },
      -- java = { 'google_java_format' }, redundant with JDTLS formatting
      python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
      -- bash = { 'shfmt' },
      -- sh = { 'shfmt' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      arduino = { 'clang-format' },
      asm = { 'asmfmt' },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
