return {
  --TODO: IMPROVE IT LATER
  --HACK: Well... Refactoring ???
  'epwalsh/obsidian.nvim',
  version = '*', -- Use latest release
  lazy = true,
  ft = 'markdown', -- Load for markdown files
  -- Optional: Load for specific markdown files in a vault
  -- event = { "BufReadPre path/to/my-vault/**.md", "BufNewFile path/to/my-vault/**.md" },
  opts = {
    workspaces = {
      { name = 'software-work', path = '~/Developer/dev-doc/obsidian-software' },
      -- Additional workspaces can be defined here
    },
    notes_subdir = '01-zettelkasten', -- Subdirectory for notes

    -- Completion settings,
    ---@nvim_cmpet set to false to disable completion.
    completion = { nvim_cmp = true, min_chars = 2 },

    -- Customize wiki link formatting
    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format('[[%s]]', opts.label)
      elseif opts.label ~= opts.id then
        return string.format('[[%s|%s]]', opts.id, opts.label)
      else
        return string.format('[[%s]]', opts.id)
      end
    end,

    -- Customize ID for new notes
    note_id_func = function(title)
      local suffix = title and title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower() or ''
      if not title then
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    -- Customize markdown link formatting
    ---@param opts {path: string, label: string, id: string|?}
    ---@return string
    markdown_link_func = function(opts)
      return string.format('[%s](%s)', opts.label, opts.path)
    end,

    -- Customize frontmatter for notes

    note_frontmatter_func = function(note)
      -- Get current date and time in the specified format.
      local current_time = os.date '%Y-%m-%d %H:%M:%S'

      -- Always update the 'updated' field to the current time on save (:wa).
      note.updated = current_time

      -- Prepare the frontmatter output, initially including 'id', 'aliases', 'tags', and 'updated'.
      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        updated = note.updated,
      }

      -- If 'created' field doesn't exist, set it to the current time.
      -- This happens only once, when the note is first saved.
      if note.created == nil then
        note.created = current_time
        out.created = note.created
      else
        -- If 'created' already exists, just carry it over unchanged.
        out.created = note.created
      end

      -- If there are any additional metadata fields, add them to the output.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    -- For templates
    templates = {
      subdir = '04-templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Customize the tags interface.
    tags = { height = 10, wrap = true },

    mappings = {
      ['<leader>oi'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = 'Get [I]nside note' },
      },
      -- Toggle check-boxes.
      ['<leader>oc'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = 'Toggle [C]heckbox in Obsidian note' },
      },
    },

    picker = {
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
    },
  },
}
