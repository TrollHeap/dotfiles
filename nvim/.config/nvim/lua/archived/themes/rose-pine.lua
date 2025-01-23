return {
  'rose-pine/neovim',
  name = 'rose-pine',
  enabled = true,
  config = function()
    require('rose-pine').setup {
      variant = 'main',
      dark_variant = 'main',
      styles = {
        transparency = true,
      },
    }
    vim.cmd [[colorscheme rose-pine]]
  end,
}
