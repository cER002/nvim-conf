return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'lua',
        'vim',
        'regex',
        'python',
        'css',
        'yaml',
        'java',
        'bash',
        'html',
        'markdown',
        'markdown_inline',
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
