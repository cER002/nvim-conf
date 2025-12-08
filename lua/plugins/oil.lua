return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    --{ "echasnovski/mini.icons", opts = {} },
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    default_file_explorer = true, --takes over nvim default :Ex(plorer)

    columns = { 'icon', 'size' },
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },

    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },

    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,

    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = false,
    },

    constrain_cursor = 'editable',
    watch_for_changes = false,

    use_default_keymaps = true, --keymaps please learn
    keymaps = {
      ['g?'] = { 'actions.show_help', mode = 'n' }, -- help
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
      ['<C-t>'] = { 'actions.select', opts = { tab = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = { 'actions.close', mode = 'n' }, -- close oil
      ['<F5>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' }, -- to parent dir
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' }, -- show hidden folders
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    },

    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr) return name:match '^%.' ~= nil end,
      is_always_hidden = function(name, bufnr) return false end,
      natural_order = 'fast',
      case_insensitive = false,
      sort = { { 'type', 'asc' }, { 'name', 'asc' } },
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan) return nil end,
    },

    float = {
      padding = 1,
      max_width = 0.9,
      max_height = 0.9,
      border = 'rounded',
      win_options = {
        winblend = 0, -- transparency setting
      },
      preview_split = 'auto',
      override = function(conf) return conf end,
    },

    preview_win = {
      update_on_cursor_moved = true,
      preview_method = 'fast_scratch',
      disable_preview = function(filename) return false end,
      win_options = {},
    },

    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = 'rounded',
      win_options = { winblend = 0 }, --more transparency
    },

    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = 'rounded',
      minimized_border = 'none',
      win_options = { winblend = 0 }, -- MORE TRANSPARENCY
    },

    keymaps_help = { border = 'rounded' },
  },
  config = function(_, opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    vim.keymap.set('n', '<leader>e', function() require('oil').open_float(vim.loop.cwd()) end, { desc = 'Oil (float)' })
  end,
}
