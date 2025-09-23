-- plugin/myhello.lua

vim.api.nvim_command("HelloWorld", function()
	require("myjava").hello()
end, {})
