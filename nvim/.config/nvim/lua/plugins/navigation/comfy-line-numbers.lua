return {
  'mluders/comfy-line-numbers.nvim',
  config = function()
    require('comfy-line-numbers').setup({
      labels = {
        '1', '2', '3', '4', '11', '12', '13', '14', '21', '22', '23',
        '24', '31', '32', '33', '34', '41', '42', '43', '44', '111', '112',
        '113', '114', '121', '122', '123', '124', '131', '132', '133', '134',
        '141', '142', '143', '144', '211', '212', '213', '214', '221', '222',
        '223', '224', '231', '232', '233', '234', '241', '242', '243', '244',
      },
      up_key = 'k',
      down_key = 'j',

      -- Line numbers will be completely hidden for the following file/buffer types
      hidden_file_types = {
        "undotree", "TelescopePrompt", "dashboard", "help", "notify", "lazy"
      },
      hidden_buffer_types = { "terminal", "nofile", "quickfix", "prompt" }
    })
  end
}
