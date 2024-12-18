return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    {
      'tpope/vim-dadbod',
      lazy = true,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql', 'psql', 'redis-cli' },
      lazy = true,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = 'right'
    vim.g.db_ui_hide_schemas = { 'pg_catalog', 'pg_toast_temp.*', 'pg_toast' }
    vim.keymap.set('n', '<leader>D', '<cmd>DBUI<CR>', { desc = 'DATABASE' })
  end,
}
