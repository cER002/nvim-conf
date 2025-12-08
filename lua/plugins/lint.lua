return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      lua = { 'luacheck' },
      java = { 'checkstyle' },
      python = { 'ruff' },
      sh = { 'shellcheck' },
    }

    lint.linters.luacheck.args = { 'vim' }
    table.insert(lint.linters.shellcheck.args, 1, '-x')
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function() lint.try_lint() end,
    })
  end,
}
