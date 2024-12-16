return {
  'dreamsofcode-io/ChatGPT.nvim',
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    require("chatgpt").setup({
      async_api_key_cmd = "pass show config/api/openai",
      openai_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 500,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "code-davinci-002",
        temperature = 0,
        max_tokens = 300,
        n = 1,
      },
    })
  end,
}
