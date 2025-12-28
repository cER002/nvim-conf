return {
  ---@module "blink-cmp"
  'saghen/blink.cmp',
  event = { 'CmdlineEnter', 'InsertEnter' },
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
  },
  build = 'cargo build --release',
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-Space>'] = { 'accept', 'fallback' },
      ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
    },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
    appearance = { nerd_font_variant = 'normal' },
    completion = {
      keyword = { range = 'prefix' },
      accept = { auto_brackets = { enabled = false } },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      menu = {
        border = 'rounded',
        scrollbar = false,
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'rounded',
          max_width = 80,
          max_height = 20,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning', prebuilt_binaries = { download = false } },
  },
  opts_extend = { 'sources.default' },
}
