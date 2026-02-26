-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.run()
	local mains = vim.fn.systemlist("grep -rl 'public static void main'")
	if #mains == 0 then
		print("❌ Keine Main-Methode gefunden")
		return
	end

	-- nimm erstmal die erste gefundene Datei
	local main_file = mains[1]

	-- 3. Dateipfad -> Klassennamen
	-- Beispiel: ./src/com/example/App.java -> com.example.App
	local classname = main_file
	classname = classname:gsub("^%.", "") -- führendes ./ weg
	classname = classname:gsub("%.java$", "") -- .java weg
	classname = classname:gsub("src.", "") -- / -> .

	local term_buf = vim.fn.bufnr("term://*")
	if term_buf ~= -1 then
		vim.cmd("bd! " .. term_buf) -- Buffer killen (bd! = buffer delete)
	end
	vim.cmd("botright 10split | terminal java -cp out " .. classname)
end

function M.compile()
	local root = vim.fn.getcwd()
	local out = root .. "/out"
	local continue = true

	-- create out dir
	vim.fn.mkdir(out, "p")

	-- find alle java files
	local handle = io.popen("find " .. root .. " -name '*.java'")
	local files = handle:read("*a")
	handle:close()

	-- temporäre Datei mit Fileliste
	local listfile = root .. "/sources.txt"
	local f = io.open(listfile, "w")
	f:write(files)
	f:close()

	local stdout_data = {}
	local stderr_data = {}
	local term_buf = vim.fn.bufnr("term://*")
	--vim.cmd("botright 10split | terminal javac @" .. listfile .. " -d " .. out)
	local compile_job = vim.fn.jobstart({ "javac", "@" .. listfile, "-d", out }, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = collect_output(stdout_data),
		on_stderr = collect_output(stderr_data),
	})

	-- wartet max. 30 Sekunden
	local result = vim.fn.jobwait({ compile_job }, 30000)
	vim.notify("wait")
	if result[1] == 0 then
		return stdout_data
	elseif result[1] == -1 then
		print("Jobwait timed out")
	else
		print("Compile failed with exit code: " .. result[1])
	end
	-- compile
	--	vim.fn.jobstart({ "javac", "@" .. listfile, "-d", out }, {
	--	stdout_buffered = true,
	--on_stdout = function(_, data)
	--vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
	--	if data then
	--	vim.list_extend(stdout_data, data)
	--	vim.notify("test")
	-- M.run()
	--	end
	--end,
	--on_stderr = function(_, data)
	--	if data then
	--		vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
	--		local term_buf = vim.fn.bufnr("term://*")
	--		if term_buf ~= -1 then
	-- vim.cmd("bd! " .. term_buf) -- Buffer killen (bd! = buffer delete)
	--	end
	--	end
	--end,
	--})
	--
end

function collect_output(target_table)
	return function(_, data)
		if data then
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(target_table, line)
				end
			end
		end
	end
end

return M
