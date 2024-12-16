return {
  'catppuccin/nvim',
  name = 'catppuccin-mocha',
  priority = 1000,
  enabled = true,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = false,
      },
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
