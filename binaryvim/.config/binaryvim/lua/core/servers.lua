return {
  -- C and C++
  clangd = {},
  html = {},
  cssls = {},
  jsonls = {},
  yamlls = {},

  bashls = {},

  -- TS/JS
  ts_ls = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
    -- Exclude 'vue' from tsserver to ensure volar handles Vue files
  },
  volar = {
    filetypes = { 'vue' }, -- Ensure that only volar handles Vue files
    init_options = { vue = { hybridMode = false } },
  },
  -- PHP
  intelephense = {
    filetypes = { 'php', 'blade' },
    settings = {
      intelephense = {
        files = {
          associations = { '*.php', '*.blade.php' }, -- Associating .blade.php files as well
          maxSize = 5000000,
        },
      },
    },
  },
  -- LUA
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  -- PYTHON
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'E501' }, -- This is the Error code for line too long.
            maxLineLength = 200  -- This sets how long the line is allowed to be. Also has effect on formatter.
          },
        },
      },
    },
  },

  -- CSharp
  omnisharp = {
    cmd = {
      "omnisharp",
      "--languageserver",
      "--hostPID", tostring(vim.fn.getpid()),
      "--encoding", "utf-8",
      "RoslynExtensionsOptions:EnableAnalyzersSupport=false",
      "RoslynExtensionsOptions:EnableImportCompletion=true",
      "FormattingOptions:OrganizeImports=true",
    },
    settings = {
      omnisharp = {
        useModernNet = true,
        formattingOptions = {
          enableEditorConfigSupport = true, -- Disable .editorconfig formatting
          organizeImports = true,           -- Disable auto-organized imports
        },
        enableRoslynAnalyzers = true,       -- Disable Roslyn-based analyzers
      },
    },
    filetypes = { "cs", "vb" },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
    end,
  },
  -- csharp_ls = {},
}
