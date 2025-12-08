return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    theme = 'tokyonight',
    sections = {
      lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
      lualine_b = { 'branch' },
      lualine_c = {
        {
          'filename',
          path = 1,
          fmt = function(str)
            local result = string.gsub(str, '^oil:///', '')
            result = string.gsub(result, '^home', '~')
            return result
          end,
        },
      },
      lualine_x = { 'location' },
      lualine_y = { { 'lsp_status', ignore_lsp = { 'Github Copilot', 'copilot' } } },
      lualine_z = { { 'filetype', separator = { right = '' }, left_padding = 2 } },
    },
    options = {
      icons_enabled = true,
      globalstatus = true,
      component_separators = { left = '|', right = '|' },
      section_separators = { left = '', right = '' },
    },
  },
}
