return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  event = 'VeryLazy',
  opts = {
    background_colour = '#000000',
    views = {
      cmdline_popup = {
        position = {
          row = '40%',
          col = '50%',
        },
        win_options = {
          winblend = 20,
        },
      },
    },
    lsp = {
      hover = {
        enabled = true,
        opts = {
          border = {
            style = 'rounded',
          },
          size = {
            max_width = 80,
            max_height = 20,
          },
        },
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true,
          luasnip = true,
        },
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = false,
    },
  },
}
