return {
  'adalessa/laravel.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'tpope/vim-dotenv',
    'MunifTanjim/nui.nvim',
    'nvimtools/none-ls.nvim',
  },
  cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
  keys = {
    { '<leader>ia', ':Laravel artisan<cr>' },
    { '<leader>ir', ':Laravel routes<cr>' },
    { '<leader>im', ':Laravel related<cr>' },
  },
  event = { 'VeryLazy' },
  config = true,
}
