return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- Load the LSP servers configuration
    local servers = require('core.servers')

    -- Define the configuration for LSP servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Configure each LSP server
    for server_name, config in pairs(servers) do
      if require('lspconfig')[server_name] then
        require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', {
          capabilities = capabilities,
        }, config))
      else
        vim.notify("LSP server not supported: " .. server_name, vim.log.levels.WARN)
      end
    end

    -- Setup Mason
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers), -- Ensure the specified LSP servers are installed
    }

    -- Log LSP attach events
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
          vim.notify("LSP attached: " .. client.name, vim.log.levels.INFO)
        end
      end,
    })
  end,
}
