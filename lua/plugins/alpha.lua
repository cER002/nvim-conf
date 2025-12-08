return {
  'goolord/alpha-nvim',
  -- dependencies = { 'echasnovski/mini.icons' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local v = vim.version()
    local version = ' v' .. v.major .. '.' .. v.minor .. '.' .. v.patch
    -- available: devicons, mini, default is mini
    -- if provider not loaded and enabled is true, it will try to use another provider
    dashboard.section.header.val = {
      [[                                                                         ]],
      [[                *              ____yyyyy___              +       .       ]],
      [[      o                    _y~`            `~~__                         ]],
      [[                        _~~                     ~y_                      ]],
      [[                .     _~                           ~y_          +        ]],
      [[  *                 :~        __y~~`` ``~~y_          ~~y__________yw=`  ]],
      [[           +       y~       _~   _.----'L_  `~_                __y~`     ]],
      [[                  _:      y`  ,=~:       `^<,  ~_         __y~`          ]],
      [[    .            :~      F  yf:             ~v_y~'   __y~`               ]],
      [[                 F      y  y^           :_y~~   __y~`                    ]],
      [[           *    :      ::  F       __y~~   __y~`                 .       ]],
      [[               F       F__F~~`  '_ya~`        u' l    `,                 ]],
      [[       +      F        `   __y~`             :/  F     F                 ]],
      [[            _`       __ya~`                 :/. y     ::        o        ]],
      [[         '_~   __ya~`      _ :=_          _x^  y:     F                  ]],
      [[      _y~__ya~`          _~:~_ :~=-uLLL:=f`  _~      y                   ]],
      [[   .=fa~`               y     ~y_         __~       F     *          +   ]],
      [[                +       4        `~~~y~~~`        _`                     ]],
      [[                         `y,                   :_~                       ]],
      [[          o                :~y_             __~`                  o      ]],
      [[                    *          :~~~yyyyyy~~`           +                 ]],
      [[      .                                                      . 	       ]],
    }

    dashboard.section.header.opts.hl = 'HeaderA'
    dashboard.section.footer.opts.hl = 'FooterA'
    dashboard.section.buttons.val = {
      dashboard.button('e', '󱏒  file explorer', ':Oil<CR>'),
      dashboard.button('f', '󰈞  find file', ':Telescope find_files<CR>'),
      dashboard.button('l', '󰒲  lazy', ':Lazy<CR>'),
      dashboard.button('d', '  dotfiles', ':e ~/.config/<CR>'),
      dashboard.button('n', '  neovim settings', ':e ~/.config/nvim/<CR>'),
      dashboard.button('h', '  hyprland settings', ':e ~/.config/hypr/<CR>'),
      dashboard.button('q', '  quit neovim', ':qa<CR>'),
    }
    local function centerText(text, width)
      local totalPadding = width - #text
      local leftPadding = math.floor(totalPadding / 2)
      local rightPadding = totalPadding - leftPadding
      return string.rep(' ', leftPadding) .. text .. string.rep(' ', rightPadding)
    end

    dashboard.section.footer.val = {
      centerText('neovim ' .. version, 50),
    }

    alpha.setup(dashboard.opts)

    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
    vim.cmd [[autocmd FileType alpha set laststatus=0 | autocmd BufUnload <buffer> set laststatus=2]]
  end,
}
