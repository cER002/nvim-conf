return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      lua = { 'luacheck' },
      java = { 'checkstyle' },
      sh = { 'shellcheck' },
      c = { 'cpplint' },
      cpp = { 'cpplint' },
    }

    lint.linters.luacheck.args = { 'vim' }
    table.insert(lint.linters.shellcheck.args, 1, '-x')
  end,
}
