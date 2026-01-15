return {
  ---@module "telescope"
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<esc>'] = require('telescope.actions').close,
        },
      },
      layout_strategy = 'center',
      layout_config = {
        anchor = 'S',
        height = 0.40,
        width = 0.99,
        preview_cutoff = 1,
      },
    },
  },
}
