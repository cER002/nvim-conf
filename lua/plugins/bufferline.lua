return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  opts = {
    options = {
      mode = 'buffers',
      themable = true,
      numbers = 'none',
      diagnostics = 'nvim_lsp',
      show_close_icon = false,
      show_buffer_close_icons = true,
      indicator = {
        style = 'none',
      },
      separator_style = 'thin',
      offsets = {
        {
          filetype = 'oil',
          text = 'File Explorer',
          highlight = 'Directory',
          separator = false,
        },
      },
    },
  },
}
