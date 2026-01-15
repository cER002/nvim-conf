return {
  'mfussenegger/nvim-dap',
  event = { 'LspAttach' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    {
      'rcarriga/nvim-dap-ui',
      opts = {
        layouts = {
          {
            elements = { 'scopes', 'breakpoints', 'stacks', 'watches' },
            size = 40,
            position = 'left',
          },
          {
            elements = { 'repl', 'console' },
            size = 10,
            position = 'bottom',
          },
        },
      },
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup {
          enabled = true,
          enabled_commands = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = false,
          show_stop_reason = true,
          commented = false,
          only_first_definition = true,
          all_references = false,
          clear_on_continue = false,
          display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value:gsub('%s+', ' ')
            else
              return variable.name .. ' = ' .. variable.value:gsub('%s+', ' ')
            end
          end,

          virt_text_pos = 'eol',
        }
      end,
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local map = vim.keymap.set

    map('n', '<leader>dt', dapui.toggle, { desc = 'DAPUI Toggle' })
    map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP Toggle Breakpoint' })
    map('n', '<leader>dc', dap.continue, { desc = 'DAP Continue' })
    map('n', '<F9>', dap.step_into, { desc = 'DAP Step Into' })
    map('n', '<F10>', dap.step_over, { desc = 'DAP Step Over' })
    map('n', '<leader>dr', dap.repl.open, { desc = 'DAP Open REPL' })

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end

    vim.fn.sign_define('DapBreakpoint', {
      text = '🛑',
      texthl = 'DiagnosticSignError',
      linehl = 'Pmenu',
      numhl = 'DiagnosticSignError',
    })

    vim.fn.sign_define('DapStopped', {
      text = '▶',
      texthl = 'DiagnosticSignInfo',
      linehl = 'CursorLine',
      numhl = 'DiagnosticSignInfo',
    })

    dap.configurations.java = {
      {
        type = 'java',
        request = 'launch',
        name = 'Launch Main Class',
      },
    }
  end,
}
