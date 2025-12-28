-- local colors = require('config.colors')

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000, -- load before other plugins
    opts = {
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    -- on_colors = colors,
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre' },
    opts = { '*' },
  },
}
