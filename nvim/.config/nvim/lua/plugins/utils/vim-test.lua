return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  vim.keymap.set('n', '<leader>un', ':TestNearest<CR>'),
  vim.keymap.set('n', '<leader>uf', ':TestFile<CR>'),
  vim.keymap.set('n', '<leader>ua', ':TestSuite<CR>'),
  vim.keymap.set('n', '<leader>ul', ':TestLast<CR>'),
  vim.keymap.set('n', '<leader>uv', ':TestVisit<CR>'),
  vim.cmd 'let test#strategy = "vimux"',
}
