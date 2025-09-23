-- plugin/myjava.lua
vim.api.nvim_create_user_command("HelloWorld", function()
	require("myjava").greeting()
end, {})

vim.api.nvim_create_user_command("CompileAndRunJava", function()
	require("myjava").compileAndnRun()
end, {})
