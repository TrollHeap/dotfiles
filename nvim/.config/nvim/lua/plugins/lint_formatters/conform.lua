return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      html = { 'prettier' },
      css = { 'prettier' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', "prettier" },
      vue = { 'prettier' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      csharp = { 'csharpier' },
      sh = { "beautysh" },
      bash = { "beautysh" },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
    },
  },
}
