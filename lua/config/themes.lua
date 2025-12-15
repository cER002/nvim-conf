local colors = require('config.colors')
local M = {}

M.lualine = {
  normal = {
    -- Section A: Filetype/Mode indicator.
    a = { bg = colors.color9, fg = colors.foreground, gui = 'bold' },
    -- Section B: Git/LSP Status.
    b = { bg = colors.color7, fg = colors.background },
    -- Section C: Status/Line info.
    c = { bg = colors.background, fg = colors.foreground },
  },
  insert = {
    a = { bg = colors.color8, fg = colors.foreground, gui = 'bold' },
    b = { bg = colors.color7, fg = colors.background },
    c = { bg = colors.background, fg = colors.foreground },
  },
  visual = {
    a = { bg = colors.color2, fg = colors.foreground, gui = 'bold' },
    b = { bg = colors.color7, fg = colors.background },
    c = { bg = colors.background, fg = colors.foreground },
  },
  replace = {
    a = { bg = colors.color10, fg = colors.foreground, gui = 'bold' },
    b = { bg = colors.color7, fg = colors.background },
    c = { bg = colors.background, fg = colors.foreground },
  },
  command = {
    a = { bg = colors.color4, fg = colors.foreground, gui = 'bold' },
    b = { bg = colors.color7, fg = colors.background },
    c = { bg = colors.background, fg = colors.foreground },
  },
  inactive = {
    a = { bg = colors.inactive_background, fg = colors.inactive_foreground, gui = 'bold' },
    b = { bg = colors.inactive_background, fg = colors.inactive_foreground },
    c = { bg = colors.inactive_background, fg = colors.inactive_foreground },
  },
}

return M
