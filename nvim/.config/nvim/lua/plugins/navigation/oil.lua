return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  },
  config = function()
    require("oil").setup({})
  end,
  -- Neotree
}
