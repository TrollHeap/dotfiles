return {
  'ramojus/mellifluous.nvim',
  enabled = true,
  config = function()
    require('mellifluous').setup {
      color_set = 'kanagawa_dragon',
      transparent_background = {
        enabled = true,
        floating_windows = true,
        telescope = true,
        file_tree = true,
        cursor_line = true,
        status_line = true,
      },
    }
    vim.cmd [[colorscheme mellifluous]]
  end,
}
