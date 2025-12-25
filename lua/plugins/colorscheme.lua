return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000, -- load before other plugins
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre' },
    opts = { '*' },
  },
}
