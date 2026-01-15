return {
  ---@module "lualine"
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_a = { { 'mode', right_padding = 2 } },
      lualine_b = { 'branch' },
      lualine_c = {
        {
          'filename',
          path = 1,
          fmt = function(str)
            local result = string.gsub(str, '^oil:///home/cer', '~')
            return result
          end,
        },
      },
      lualine_x = { 'diagnostics', 'diff', 'location' },
      lualine_y = { { 'lsp_status', icon = ' ' } },
      lualine_z = { 'encoding', { 'filetype', left_padding = 2 } },
    },
    options = {
      theme = require('cer.config.themes').lualine,
      icons_enabled = true,
      globalstatus = true,
      component_separators = { left = '|', right = '|' },
      section_separators = { left = '', right = '' },
    },
  },
}
