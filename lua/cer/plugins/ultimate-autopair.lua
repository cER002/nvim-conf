return {
  'altermo/ultimate-autopair.nvim',
  event = { 'InsertEnter' },
  opts = {
    fastwarp = {
      multi = true,
      { faster = true, map = '<C-E>', cmap = '<C-E>' },
      { faster = false, map = '<C-e>', cmap = '<C-e>' },
    },

    tabout = {
      enable = true,
      map = '<C-l>',
      cmap = '<C-l>',
      hopout = true,
    },
  },
}
