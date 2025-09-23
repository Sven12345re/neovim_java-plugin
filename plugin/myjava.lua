-- plugin/myjava.lua
vim.api.nvim_create_user_command("HelloWorld", function()
	require("myjava").hello()
end, {})
