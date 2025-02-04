return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'jose-elias-alvarez/null-ls.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        -- Lua formatter
        null_ls.builtins.formatting.stylua,

        -- JavaScript, TypeScript, CSS, HTML, JSON, Vue, and Python formatter
        null_ls.builtins.formatting.prettier.with {
          filetypes = { 'javascript', 'typescript', 'css', 'html', 'json', 'vue', 'python' },
        },

        -- JavaScript and TypeScript linter
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.diagnostics.eslint,

        -- Spell checking
        null_ls.builtins.completion.spell,

        -- Python formatters and linters
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,

        -- Shell formatters and linters
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,

        -- Csharp formatters and linters
        null_ls.builtins.formatting.dotnet_format,
        null_ls.builtins.diagnostics.dotnet_diagnostic,

      },
    }
  end,
}
