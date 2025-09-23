local M = {}

function M.hello_world()
  print("Hello, World!")
end

-- Map a command to the function
vim.api.nvim_command('command! HelloWorld lua require("java-plugin").hello_world()')

return M
