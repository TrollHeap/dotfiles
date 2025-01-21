-- Neovim Global Settings
vim.g.mapleader = ' '         -- Set leader key
vim.g.maplocalleader = ' '    -- Set local leader key
vim.g.copilot_enabled = false -- Disable GitHub Copilot by default
vim.g.editorconfig = false    -- Disable EditorConfig by default
vim.opt.laststatus = 3        -- Always show statusline

-- User Interface Options
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.mouse = 'a'               -- Enable mouse support
vim.opt.showmode = false          -- Do not show mode (we use statusline plugins for that)
vim.opt.signcolumn = 'yes'        -- Always show the sign column
vim.opt.cursorline = true         -- Highlight the current line
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard

-- Editor Behavior Options
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of indentation
vim.opt.smartcase = true -- Case-insensitive searching unless capital letters are used
vim.opt.hlsearch = true  -- Highlight search matches

-- File and Buffer Management
vim.opt.undofile = true  -- Save undo history
vim.opt.backup = false   -- Disable backup
vim.opt.swapfile = false -- Disable swapfile

-- Whitespace Management
vim.opt.wrap = false -- Disable line wrapping
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Set listchars for whitespace

-- Performance
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 150 -- Faster key sequence completion

-- Window Management
vim.opt.splitright = true -- Vertical splits will open on the right
vim.opt.splitbelow = true -- Horizontal splits will open below

-- Additional Options
vim.opt.breakindent = true   -- Enable break indent
vim.opt.inccommand = 'split' -- Show incremental command previews
vim.opt.scrolloff = 10       -- Keep at least 10 lines above/below
vim.wo.conceallevel = 0      -- Conceal markup

-- Filetype Specific Options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.conceallevel = 2 -- Conceal markup for markdown files
  end,
})

-- Highlight yank text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- TODO: Add keybindings for toggling line wrapping, etc.
-- You would place custom key mappings here, possibly using a similar callback structure
-- for setting up filetype-specific keybindings.
