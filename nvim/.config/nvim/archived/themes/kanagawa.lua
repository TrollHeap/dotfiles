return {
  'rebelot/kanagawa.nvim',
  enabled = true,
  config = function()
    require('kanagawa').setup {
      transparent = true,
    }
    vim.cmd.colorscheme 'kanagawa-wave'
    -- You can configure highlights by doing something like
  end,
}
