return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { 'gR', desc = 'LSP references', mode = 'n' },
      { 'gd', desc = 'LSP definitions', mode = 'n' },
      { 'gh', desc = 'Hover information', mode = 'n' },
      { 'gi', desc = 'LSP implementations', mode = 'n' },
      { 'gD', desc = 'LSP buffer declaration', mode = 'n' },
      { 'gs', desc = 'LSP workspace symbols', mode = 'n' },
      { '<F2>', desc = 'LSP buffer rename', mode = 'n' },
      { '<F4>', desc = 'LSP buffer code action', mode = 'n' },
      { '<leader>jtc', desc = 'JDTLS test class', mode = 'n' },
      { '<leader>jtm', desc = 'JDTLS test nearest method', mode = 'n' },
    },
    plugins = {
      marks = true,
      presets = {
        operators = false,
        motions = false,
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function() require('which-key').show { global = false } end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
