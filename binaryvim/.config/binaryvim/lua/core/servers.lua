return {
  -- C and C++
  clangd = {},
  html = {},
  cssls = {},
  jsonls = {},
  yamlls = {},

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
  -- JAVA
  jdtls = {},
}
