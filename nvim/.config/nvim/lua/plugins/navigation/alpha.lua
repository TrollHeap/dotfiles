return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    -- Button/Menu Section
    dashboard.section.buttons.val = {
      -- Find Files
      dashboard.button('f', '  Find Files', ':Telescope find_files<CR>'),
      -- Recent Files
      dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
      -- Find Config Files
      dashboard.button('c', '󰮗  Find Config', ':Telescope find_files cwd=' .. vim.fn.stdpath 'config' .. '<CR>'),
      -- Configure Lazy
      dashboard.button('l', '  Config Lazyvim', ':Lazy <CR>'),
      -- Configure Mason
      dashboard.button('m', '  Config Mason', ':Mason<CR>'),
      -- Quit
      dashboard.button('q', '󱞴  Quit NVim', ':qa<CR>'),
    }
    -- Footer
    dashboard.section.footer.val = {
      'Ad augusta per angusta',
    }

    -- Adjust this option if necessary to customize the footer
    dashboard.section.footer.opts.hl = 'Type'

    -- Adjust this option to center the footer content
    dashboard.section.footer.opts.position = 'center'

    alpha.setup(dashboard.opts)
  end,
}
