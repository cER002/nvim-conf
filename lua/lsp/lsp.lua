return {
  { 'neovim/nvim-lspconfig', event = { 'VeryLazy' } },
  {
    'mason-org/mason.nvim',
    event = { 'BufNewFile', 'BufReadPre' },
    ---@module "mason"
    ---@type MasonSettings
    opts = {
      ui = {
        backdrop = 100,
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim', -- helps translating names between nvim-lspconfig and mason
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    event = { 'BufNewFile', 'BufReadPre' },
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = {
      ensure_installed = {
        'systemd_lsp',
        'clangd',
        'cssls',
        -- 'rust_analyzer', use system version
        'arduino_language_server',
        'basedpyright',
        'ruff',
        'jdtls',
        'lua_ls',
        'stylua',
        'bashls',
        'hyprls',
        'bashls',
        'jsonls',
        'yamlls',
        'qmlls',
      },
      automatic_enable = false,
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'mfussenegger/nvim-jdtls',
    ---@module "jdtls"
    ft = { 'java' },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    ---@module "render-markdown"
    opts = {
      file_types = { 'markdown', 'copilot-chat' },
      completions = { lsp = { enabled = true } },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },
  {
    'b0o/SchemaStore.nvim',
  },
}
