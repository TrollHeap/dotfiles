return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>a",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Avante"
    },
    {
      "<leader>b",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer"
    },
    {
      "<leader>c",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Code"
    },
    {
      "<leader>d",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Debugger"
    },
    {
      "<leader>f",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Find"
    },
    {
      "<leader>g",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Git & Goto"
    },
    {
      "<leader>s",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Search"
    },
    {
      "<leader>o",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Obsidian"
    },

    {
      "<leader>t",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Terminal"
    },
    {
      "<leader>u",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Units Test"
    },
  },
}
