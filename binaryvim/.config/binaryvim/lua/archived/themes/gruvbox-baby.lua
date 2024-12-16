return {
  'luisiacc/gruvbox-baby',
  enabled = true,
  config = function()
    vim.g.gruvbox_baby_background_color = 'dark'
    vim.cmd.colorscheme 'gruvbox-baby'
    -- transparent
  end,
}
