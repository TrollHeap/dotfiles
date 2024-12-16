return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        mode = 'buffers', -- Utilisez le mode buffers
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        -- Personnalisation des offsets pour intégrer avec NvimTree ou autres plugins similaires
        offsets = {
          { filetype = 'NeoTree', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        show_buffer_close_icons = false, -- Désactiver les icônes de fermeture si vous n'utilisez pas la souris
        show_close_icon = false,
        color_icons = true, -- Activer les icônes colorées (nécessite 'nvim-web-devicons')
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, diagnostics_hint, context)
          local icon = level:match 'error' and ' ' or (level:match 'warning' and ' ') or ' '
          return ' ' .. '%#' .. 'DiagnosticSign' .. (level:gsub('^%l', string.upper)) .. '#' .. icon .. count .. '%*'
        end,
        name_formatter = function(buf) -- buf: l'objet tampon
          if buf.name:match '%.md' then
            return vim.fn.fnamemodify(buf.name, ':t:r')
          end
        end,
        numbers = function(opts)
          return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
        end,
      },
    }
  end,

  -- Custom command to close the current buffer and move to the left buffer
  vim.api.nvim_create_user_command('CloseBufferAndGoLeft', function()
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()
    local target_buf = nil

    -- Filtrer les tampons pour ne garder que ceux éligibles
    local eligible_buffers = {}
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
        table.insert(eligible_buffers, buf)
      end
    end

    -- Trouver le tampon cible à gauche
    for i, buf in ipairs(eligible_buffers) do
      if buf == current_buf and i > 1 then
        target_buf = eligible_buffers[i - 1]
        break
      end
    end

    -- Fermer le tampon actuel et passer au tampon cible si trouvé
    vim.cmd(':bd ' .. current_buf)
    if target_buf then
      vim.cmd(':buffer ' .. target_buf)
    end
  end, { desc = 'Close current buffer and move to the left buffer' }),

  -- Keybindings
  vim.keymap.set('n', '<leader>x', ':CloseBufferAndGoLeft<CR>', { noremap = true, silent = true }),
  vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true }),
  vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true }),
  vim.keymap.set('n', '<leader>ba', ':BufferLineCloseOthers<CR>', { noremap = true, silent = true }),
  vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true }),
  vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { noremap = true, silent = true }),
}
