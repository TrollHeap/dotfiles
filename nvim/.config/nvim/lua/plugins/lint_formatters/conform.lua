return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      bash = { "beautysh" },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      csharp = { 'csharpier' },
      css = { 'prettier' },
      html = { 'prettier' },
      javascript = { 'prettierd', 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      rust = { "rustfmt", lsp_format = "fallback" },
      sh = { "beautysh" },
      typescript = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', "prettier" },
      vue = { 'prettier' },
      yaml = { 'prettier' },
    },
  },
}
