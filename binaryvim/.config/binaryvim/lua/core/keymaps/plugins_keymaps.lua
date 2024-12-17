-- For plugins keymaps only
local PLUGINS = {}
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Copilot keymaps
function PLUGINS.copilot_keymaps()
  set('n', '<leader>ca', ':lua ToggleCopilot()<CR>', { desc = '[C]ode Toggle Copilot [A]ctive' })
end

-- Neotree keymaps
function PLUGINS.neotree()
  set('n', '<leader>e', '<CMD>Neotree toggle left<CR>', { desc = 'Open Neotre[E]' })
end

-- TodoComment keymaps
function PLUGINS.todo_keymaps()
  set('n', '<leader>ft', '<CMD>TodoTelescope keywords=TODO,FIX,WARNING,HACK<CR>',
    vim.tbl_extend('force', opts, { desc = '[F]ind Todo' }))
  set('n', '<leader>fn', '<CMD>TodoTelescope keywords=NOTE<CR>',
    vim.tbl_extend('force', opts, { desc = '[F]ind Todo: NOTE' }))
end

-- Oil keymaps
function PLUGINS.oil_keymaps()
  set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

-- Telescope keymap
function PLUGINS.telescope_keymaps()
  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'

  -- Search
  set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

  -- Buffer
  set('n', '<leader>fb', builtin.buffers, { desc = '[B]uffers Find [B]uffers' })
  -- Find
  set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
  set('n', '<leader>ff', builtin.find_files, { desc = '[F]find [F]iles' })
  set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
  set('n', '<leader>fc', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[F]ind [C]onfig files' })

  set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 0,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  set('n', '<leader>fo', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[F]ind in [O]pen Files' })
end

-- LSP keymaps
function PLUGINS.lsp_keymaps()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local key_map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      key_map('<leader>gd', require('telescope.builtin').lsp_definitions, '[D]efinition')
      key_map('<leader>gr', require('telescope.builtin').lsp_references, '[R]eferences')
      key_map('<leader>li', require('telescope.builtin').lsp_implementations, '[I]mplementation')
      key_map('<leader>lt', require('telescope.builtin').lsp_type_definitions, '[T]ype Definition')
      key_map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Find [S]ymbols')
      key_map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')
      key_map('<leader>cc', vim.lsp.buf.code_action, '[C]ode Action')
      key_map('<leader>cr', vim.lsp.buf.rename, '[R]ename')
      key_map('K', vim.lsp.buf.hover, 'Hover Documentation')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })
end

-- Barbar keymaps
function PLUGINS.barbar_keymaps()
  -- Buffer key
  set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
  set('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
  set('n', '<A-p>', '<Cmd>BufferPick<CR>', { desc = '[B]uffers [P]ick' })
  set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
  set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
  set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
  set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
  set('n', '<leader>bd', '<Cmd>BufferClose<CR>', { desc = '[B]uffers [D]elete' })
  set('n', '<leader>bx', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = '[B]uffers Close All' })
  set('n', '<leader>bl', '<Cmd>BufferCloseBuffersLeft<CR>', { desc = '[B]uffers Close Left' })
  set('n', '<leader>br', '<Cmd>BufferCloseBuffersRight<CR>', { desc = '[B]uffers Close Right' })
end

function PLUGINS.setup()
  PLUGINS.copilot_keymaps()
  PLUGINS.neotree()
  PLUGINS.todo_keymaps()
  PLUGINS.oil_keymaps()
  PLUGINS.lsp_keymaps()
  PLUGINS.barbar_keymaps()
end

return PLUGINS
