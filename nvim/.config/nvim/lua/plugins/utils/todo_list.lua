return {
  'ackeraa/todo.nvim',
  config = function()
    require("todo").setup {
      opts = {
        file_path = "/Users/binary/developer/todo_dev/todo.txt",
      },
    }
  end
}
