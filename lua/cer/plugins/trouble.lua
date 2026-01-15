-- credits to BrenoCRSilva/neovimrc for his amazing config

return {
  'folke/trouble.nvim',
  config = function()
    local trouble = require('trouble')
    trouble.setup {
      modes = {
        buffer_diagnostics = {
          mode = 'diagnostics',
          auto_open = false,
          auto_close = true,
          focus = false,
          group = false,
          indent_lines = false,
          filter = { buf = 0 },
          keys = {
            ['<cr>'] = 'jump',
            ['<esc>'] = 'close',
          },
        },
        quickfix = {
          auto_open = false,
          auto_close = true,
          focus = false,
          group = false,
          indent_lines = false,
          keys = {
            ['<cr>'] = 'jump',
            ['<esc>'] = 'close',
          },
        },
        diagnostics = {
          auto_open = false,
          auto_close = true,
          focus = false,
          group = false,
          indent_lines = false,
          keys = {
            ['<cr>'] = 'jump',
            ['<esc>'] = 'close',
          },
        },
      },
    }
    local current_trouble_mode = nil
    local function toggle_exclusive(mode)
      if trouble.is_open() and current_trouble_mode == mode then
        trouble.close()
        current_trouble_mode = nil
      else
        if trouble.is_open() then trouble.close() end
        trouble.open(mode)
        current_trouble_mode = mode
      end
    end
    vim.keymap.set('n', '<C-n>', function()
      if trouble.is_open() then trouble.next { skip_groups = true, jump = true } end
    end, { desc = 'Trouble next item' })
    vim.keymap.set('n', '<C-p>', function()
      if trouble.is_open() then trouble.prev { skip_groups = true, jump = true } end
    end, { desc = 'Trouble previous item' })
    vim.keymap.set('n', '<leader>tq', function()
      vim.fn.setqflist {}
      trouble.refresh { mode = 'quickfix' }
    end, { desc = 'Clear Quickfix and refresh Trouble' })
    vim.keymap.set('n', '<leader>tt', function() toggle_exclusive('diagnostics') end, { desc = 'Trouble diagnostics' })
    vim.keymap.set('n', '<leader>tb', function() toggle_exclusive('buffer_diagnostics') end, { desc = 'Trouble buffer diagnostics' })
    vim.keymap.set('n', '<leader>tf', function() toggle_exclusive('quickfix') end, { desc = 'Toggle Trouble Quickfix' })
  end,
}
