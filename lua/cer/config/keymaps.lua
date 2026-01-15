local map = vim.keymap.set

-- oil
map('n', '<leader>e', function() require('oil').open_float() end, { desc = 'Oil explorer (float)' })
map('n', '-', '<CMD>Oil<CR>', { desc = 'Oil open parent directory' })

-- buffer stuff
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- telescope
map('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Telescope keymaps' })
map('n', '<leader>fc', require('telescope.builtin').colorscheme, { desc = 'Telescope colorschemes' })
map('n', '<leader>ft', require('telescope.builtin').treesitter, { desc = 'Telescope treesitter' })
