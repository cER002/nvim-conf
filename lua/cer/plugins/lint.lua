return {
  ---@module "lint"
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
      make = { 'checkmake' },
    }
    -- luacheck
    lint.linters.luacheck.args = { 'vim' }

    -- Auto linting
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufWritePost', 'InsertLeave' }, {
      pattern = '*',
      callback = function() require('lint').try_lint() end,
    })
  end,
}
