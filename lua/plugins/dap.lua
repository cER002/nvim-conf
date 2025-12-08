return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup {
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
        }
      end,
    },
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup {
          enabled = true, -- enable this plugin (the default)
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
          display_callback = function(variable, buf, stackframe, node, options)
            -- by default, strip out new line characters
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value:gsub('%s+', ' ')
            else
              return variable.name .. ' = ' .. variable.value:gsub('%s+', ' ')
            end
          end,
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = 'eol',
        }
      end,
    },
  },
  event = { 'LspAttach' },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local map = vim.keymap.set

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
    map('n', '<leader>dt', dapui.toggle, { desc = 'DAPUI Toggle' })
    map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP Toggle Breakpoint' })
    map('n', '<leader>dc', dap.continue, { desc = 'DAP Continue' })
    map('n', '<F9>', dap.step_into, { desc = 'DAP Step Into' })
    map('n', '<F10>', dap.step_over, { desc = 'DAP Step Over' })
    map('n', '<leader>dr', dap.repl.open, { desc = 'DAP Open REPL' })
    dap.configurations.java = {
      {
        type = 'java',
        request = 'launch',
        name = 'Launch Main Class',
      },
    }
  end,
}
