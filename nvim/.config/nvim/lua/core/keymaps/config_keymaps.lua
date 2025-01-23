-- For config keymaps only
local CONFIG = {}
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General Mappings
function CONFIG.general_keymaps()
  set('n', '<Esc>', '<cmd>nohlsearch<CR>')
  set('t', '<leader>q', '<C-\\><C-n>', opts)
  print("General keymaps loaded")
end

-- Keymaps to resize tabs C-w + <direction> but increase by 15
function CONFIG.resize_tabs()
  set('n', '<C-w>+', '<C-w>12>', { desc = 'Increase window size by 12' })
  set('n', '<C-w>-', '<C-w>12<', { desc = 'Decrease window size by 12' })
  set('n', '<C-w>>', '<C-w>12+', { desc = 'Increase window height by 12' })
  set('n', '<C-w><', '<C-w>12-', { desc = 'Decrease window height by 12' })
end

-- Diagnostic keymaps for vim-diagnostic
function CONFIG.diagnostic_keymaps()
  set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show [C]ode [E]rror Diagnostic' })
  set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open [C]ode [Q]uick Diagnostic list' })
end

-- Disable arrow keys in normal mode
function CONFIG.disable_arrow_keys()
  set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
end

function CONFIG.setup()
  CONFIG.general_keymaps()
  CONFIG.resize_tabs()
  CONFIG.diagnostic_keymaps()
  CONFIG.disable_arrow_keys()
end

return CONFIG
