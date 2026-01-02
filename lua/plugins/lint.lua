return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      lua = { 'luacheck' },
      java = { 'checkstyle' },
      -- sh = { 'shellcheck' }, -- redundant, bashLS already runs shellcheck if it is available
      c = { 'cpplint' },
      cpp = { 'cpplint' },
    }

    lint.linters.luacheck.args = { 'vim' }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      pattern = '*',
      callback = function() require('lint').try_lint() end,
    })
  end,
}
