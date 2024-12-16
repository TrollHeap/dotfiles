return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },
  opts = {},
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dap.set_log_level('DEBUG')

    -- Mason-Nvim-DAP setup
    require('mason-nvim-dap').setup {
      automatic_setup = true,
      ensure_installed = {
        'php',
        'codelldb',
        'bash',
        'python',
        'debugpy',
      },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        php = function(config)
          config.configurations = {
            {
              type = 'php',
              request = 'launch',
              name = 'Listen for Xdebug',
              port = 9003,
              pathMappings = {
                ['${workspaceFolder}'] = '${workspaceFolder}',
                ['/var/www/html'] = '${workspaceFolder}',
              },
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    }

    -- Python configuration
    require('dap-python').setup('~/.local/share/binaryvim/mason/packages/debugpy/venv/bin/python', {
      include_configs = true,
    })

    -- DAP listeners
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    dap.listeners.after.event_exited['dapui_config'] = function()
      print('Event exited')
    end

    -- Custom event handlers for debugpy
    local function log_event(event)
      print('Debugpy session ' .. event)
    end

    dap.listeners.before.event_terminated['custom_debugpy'] = function() log_event('terminated') end
    dap.listeners.before.event_exited['custom_debugpy'] = function() log_event('exited') end
    dap.listeners.before.event_stopped['custom_debugpy'] = function() log_event('stopped') end

    vim.fn.execute('let g:dap_log_level = "DEBUG"')
    vim.fn.execute('let g:dap_python_log_level = "DEBUG"')


    -- DAP UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }


    -- Keymaps for debugging
    local keymaps = {
      ['<leader>ds'] = { dap.continue, '[D]ebug: [S]tart/Continue' },
      ['<leader>di'] = { dap.step_into, '[D]ebug: Step [I]nto' },
      ['<leader>do'] = { dap.step_over, '[D]ebug: Step [O]ver' },
      ['<leader>dO'] = { dap.step_out, '[D]ebug: Step [O]ut' },
      ['<leader>db'] = { dap.toggle_breakpoint, '[D]ebug: Toggle [B]reakpoint' },
      ['<leader>dB'] = {
        function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        '[D]ebug: Set [B]reakpoint',
      },
      ['<F7>'] = { dapui.toggle, 'Debug: See last session result.' },
    }

    for key, map in pairs(keymaps) do
      vim.keymap.set('n', key, map[1], { desc = map[2] })
    end
  end,
}
