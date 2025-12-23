return {
  { 'neovim/nvim-lspconfig' },
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'clangd',
        'arduino_language_server',
        'basedpyright',
        'ruff',
        'jdtls',
        'lua_ls',
        'stylua',
        'rust_analyzer',
        'hyprls',
        'bashls',
        'jsonls',
      },
      automatic_enable = false,
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = 'LazyVim', words = { 'LazyVim' } },
        },
      },
    },
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {
      file_types = { 'markdown', 'copilot-chat' },
      completions = { lsp = { enabled = true } },
    },
  },
}
