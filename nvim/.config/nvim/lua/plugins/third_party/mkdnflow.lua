return {
  'jakewvincent/mkdnflow.nvim',
  config = function()
    require('mkdnflow').setup({
      create_dirs = true,                      -- (optionnel) pour créer les dossiers manquants
      links = {
        create_on_follow_failure = true,       -- UX : crée le fichier s’il n’existe pas
        style                    = 'markdown', -- markdown pur, pas wikilinks
        conceal                  = true,       -- optionnel : masque source dans [Link](source.md)
        context                  = 0,
        implicit_extension       = nil,        -- pas de gestion implicite de .md (attention : liens nus non résolus si oubli)
        -- Transformation : prefixe date et slugifie
        transform_explicit       = function(text)
          return os.date('_%Y-%m-%d') .. text:gsub(" ", "-"):lower()
        end,
        transform_implicit       = false, -- désactivé ici, garde tout explicite
      },
      new_file_template = {
        use_template = true, -- ACTIVE l’usage du template
        template = [[
# {{ title }}

**Create date** : {{ date }}
**Path** : {{ filename }}
        ]],
        placeholders = {
          before = {
            -- date évaluée au moment du CR
            date = function()
              return os.date("%A, %d %B %Y") -- ex. “Mercredi, 16 juillet 2025”
            end,
          },
          after = {
            -- filename après ouverture du buffer
            filename = function()
              -- récupère le chemin complet ; vous pouvez filtrer vim.fn.fnamemodify(…, ":t")
              return vim.api.nvim_buf_get_name(0)
            end,
          },
        },
      },


      modules = { tables = false }, -- tu n’utilises pas les tableaux
      mappings = {
        MkdnFollowLink              = { 'n', '<leader>ol' },
        MkdnCreateLink              = { 'n', '<leader>oc' },
        MkdnCreateLinkFromClipboard = { 'n', '<leader>op' },
        MkdnDestroyLink             = { 'n', '<leader>od' },
        MkdnTagSpan                 = { 'v', '<leader>os' },
        MkdnToggleToDo              = { { 'n', 'v' }, '<leader>ot' },
        MkdnFoldSection             = { 'n', '<leader>of' },
        MkdnUnfoldSection           = { 'n', '<leader>ou' },
        MkdnYankAnchorLink          = { 'n', '<leader>oy' },
        MkdnYankFileAnchorLink      = { 'n', '<leader>oY' },
        MkdnMoveSource              = { 'n', '<leader>om' },
        MkdnGoBack                  = { 'n', '<leader>ob' },
        MkdnGoForward               = { 'n', '<leader>on' },
        MkdnUpdateNumbering         = false,
        MkdnNextLink                = false,
        MkdnPrevLink                = false,
      },
      to_do = {
        symbols        = { ' ', '~', 'X' }, -- [ ] = not_started, [~] = in_progress, [X] = complete
        not_started    = ' ',
        in_progress    = '~',
        complete       = 'X',
        update_parents = true,
      },
    })
  end
}
