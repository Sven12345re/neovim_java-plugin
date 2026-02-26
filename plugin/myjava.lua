-- plugin/myjava.lua
vim.api.nvim_create_user_command("HelloWorld", function()
	require("myjava").greeting()
end, {})

vim.api.nvim_create_user_command("CompileAndRunJava", function()
	local test = require("myjava").compile()
	for line in test do
		print(line)
	end
	--require("myjava").run()
end, {})

vim.api.nvim_create_user_command("CompileJava", function()
	require("myjava").compile()
end, {})

vim.api.nvim_create_user_command("RunJava", function()
	require("myjava").run()
end, {})
