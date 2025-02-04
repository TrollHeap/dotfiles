return {
  'epwalsh/obsidian.nvim',
  version = '*',   -- Use latest release
  lazy = true,
  ft = 'markdown', -- Load for markdown files
  -- Optional: Load for specific markdown files in a vault
  -- event = { "BufReadPre path/to/my-vault/**.md", "BufNewFile path/to/my-vault/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

  },
  opts = {
    workspaces = {
      {
        name = 'software-work',
        path = '~/Developer/WORKSPACE/Learning/dev-doc/obsidian-software'
      },
      -- Additional workspaces can be defined here
    },

    notes_subdir = '01-zettelkasten', -- Subdirectory for notes

    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    note_id_func = function(title)
      local suffix = title and title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower() or ''
      if not title then
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '-' .. suffix
    end,

    -- Completion settings,
    ---@nvim_cmpet set to false to disable completion.
    completion = {
      nvim_cmp = true,
      min_chars = 2
    },

    -- 🔹 Linking settings
    linking = {
      markdown_link_func = function(opts)
        return string.format('[%s](%s)', opts.label, opts.path)
      end,

      wiki_link_func = function(opts)
        return require("obsidian.util").wiki_link_id_prefix(opts)
      end,
    },


    -- 🔹 Frontmatter YAML (Note metadata)
    note_frontmatter_func = function(note)
      local current_time = os.date("%Y-%m-%d %H:%M:%S")

      -- Delete the updated field from the metadata
      if note.metadata then
        note.metadata.updated = nil
      end

      -- Initialization of metadata base
      local out = {
        id = note.id,
        aliases = note.aliases,
        tags = note.tags,
        updated = current_time,
      }

      -- If the note has a created field, we keep it
      if not note.created then
        note.created = current_time
      end
      out.created = note.created

      -- Add the metadata to the frontmatter if it exists
      if note.metadata and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    -- Daily Notes
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "01-zettelkasten/01-Dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    },

    -- For templates
    templates = {
      subdir = '03-templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Customize the tags interface.
    tags = { height = 10, wrap = true },

    mappings = {
      ['<leader>ob'] = { action = ':ObsidianBacklinks<CR>', opts = { desc = 'Show [B]acklinks to current note' } },

      -- 📅 Daily Notes
      ['<leader>od'] = { action = ':ObsidianToday<CR>', opts = { desc = 'Open Today’s [D]aily Note' } },
      ['<leader>oy'] = { action = ':ObsidianYesterday<CR>', opts = { desc = 'Open [Y]esterday’s Daily Note' } },
      ['<leader>ot'] = { action = ':ObsidianTomorrow<CR>', opts = { desc = 'Open [T]omorrow’s Daily Note' } },
      ['<leader>on'] = { action = ':ObsidianDailies<CR>', opts = { desc = 'Show all [D]aily Notes' } },
      ['<leader>oo'] = { action = ':ObsidianTOC<CR>', opts = { desc = 'Show Table [O]f Contents' } },
      ['<leader>og'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = '[G]et Inside note' },
      },
      -- Toggle check-boxes.
      ['<leader>oc'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true, desc = 'Toggle [C]heckbox in Obsidian note' },
      },
    },
  },
}
