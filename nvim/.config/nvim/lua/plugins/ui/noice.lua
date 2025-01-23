return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    --'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      views = {
        cmdline_popup = {
          position = { row = 30, col = '50%' },
          size = { width = 70, height = 'auto' },
        },
        popupmenu = {
          relative = 'editor',
          position = { row = 33, col = '50%' },
          size = { width = 70, height = 8 },
          border = { style = 'rounded', padding = { 0, 1 } },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
    }
  end,
}
