-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
	OpenOutput()
	local handle = io.popen('grep -H "public static void main" *.java | cut -d: -f1')
	local result = handle:read("*a") -- liest die gesamte Ausgabe
	local runString = string.gsub(result, ".java", "")
	handle:close()
	os.execute("javac -d class " .. result)
	os.execute("java -cp class " .. runString)
end

function OpenOutput()
	local ns = vim.api.nvim_create_namespace("HelloWorldNS")
	vim.api.nvim_create_user_command("HelloWorld2", function()
		local bufnr = vim.api.nvim_get_current_buf()
		local last_line = vim.api.nvim_buf_line_count(bufnr)

		-- Clear alte Ausgabe
		vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

		-- Setze Ausgabe als virtuellen Text unterhalb des Codes
		vim.api.nvim_buf_set_extmark(bufnr, ns, last_line - 1, 0, {
			virt_lines = { { { "Hello World 🌍", "Comment" } } },
			virt_lines_above = false,
		})
	end, {})
end
return M
