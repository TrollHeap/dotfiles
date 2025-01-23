return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local terminals = {
      lazygit = {
        cmd = 'lazygit',
        dir = 'git_dir',
        keymap = '<leader>tg',
        toggleFunc = 'lazygit_toggle',
        close_on_exit = true,
        float_opts = {
          border = 'curved',
        },
      },
      lazydocker = {
        cmd = 'lazydocker',
        dir = '~/',
        keymap = '<leader>td',
        toggleFunc = 'lazydocker_toggle',
        close_on_exit = false,
        float_opts = {
          border = 'curved',
        },
      },
      virtualTerm = {
        dir = vim.fn.getcwd(),
        keymap = '<leader>tt',
        toggleFunc = 'virtualTerm_toggle',
        close_on_exit = true,
        float_opts = {
          border = 'curved',
          width = 180,
          height = 48,
        },
      },
    }

    local function setupTerminals()
      for _, config in pairs(terminals) do
        local term = Terminal:new {
          cmd = config.cmd,
          dir = config.dir,
          direction = config.direction or 'float',
          float_opts = {
            border = config.float_opts and config.float_opts.border,
            title_pos = config.float_opts and config.float_opts.title_pos or 'center',
            width = config.float_opts and config.float_opts.width,
            height = config.float_opts and config.float_opts.height,
          },
          shade_terminals = config.shade_terminals,
          close_on_exit = config.close_on_exit,
          on_open = function(term)
            vim.cmd 'startinsert!'
            vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
          end,
          on_close = function()
            vim.cmd 'startinsert!'
          end,
        }

        _G[config.toggleFunc] = function()
          term:toggle()
        end

        vim.api.nvim_set_keymap('n', config.keymap, '<cmd>lua ' .. config.toggleFunc .. '()<CR>',
          { noremap = true, silent = true })
      end
    end

    setupTerminals()
  end,
}
