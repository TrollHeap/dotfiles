return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]parenthen
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Select inside scope
    --
    -- - vii  -  Select inside the scope
    -- - ai   -  To expand after vii the scope

    require('mini.indentscope').setup()

    vim.notify = require('mini.notify').make_notify()
    require('mini.notify').setup({
      content = {
        format = function(notif) return notif.msg end,
        sort = function(notif_arr)
          table.sort(notif_arr, function(a, b) return a.ts_update > b.ts_update end)
          return notif_arr
        end,
      },
      lsp_progress = {
        enable = true,
        duration_last = 2500,
      },
      window = {
        config = {},
        max_width_share = 0.5,
        winblend = 20,
      },
    })

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- require('mini.statusline').setup()
    -- MiniStatusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
