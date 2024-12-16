local set = vim.keymap.set
local opts = { noremap = true, silent = true }

return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,

  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    animation = true,
    insert_at_end = true,
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
    focus_on_close = 'left',
    minimum_padding = 1,
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
      },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      separator = { left = '', right = '' },

      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,

        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      buffer_selected = {
        icon = '',
        hl = 'BarbarSelected',
      },
      buffer_visible = {
        icon = '',
        hl = 'BarbarVisible',
      },
    },
  },

  -- Buffer key
  set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts),
  set('n', '<Tab>', '<Cmd>BufferNext<CR>', opts),
  set('n', '<A-p>', '<Cmd>BufferPick<CR>', { desc = '[B]uffers [P]ick' }, opts),
  set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true }),
  set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true }),
  set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true }),
  set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true }),
  set('n', '<leader>bd', '<Cmd>BufferClose<CR>', { desc = '[B]uffers [D]elete' }, opts),
  set('n', '<leader>bx', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = '[B]uffers Close All' }, opts),
  set('n', '<leader>bl', '<Cmd>BufferCloseBuffersLeft<CR>', { desc = '[B]uffers Close Left' }, opts),
  set('n', '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>', { desc = '[B]uffers Close Right' }, opts),
}
