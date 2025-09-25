-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
	io.write("\27[2J") -- Bildschirm löschen
	io.write("\27[H") -- Cursor nach oben links setzen
	local handle = io.popen('grep -H "public static void main" *.java | cut -d: -f1')
	local result = handle:read("*a") -- liest die gesamte Ausgabe
	local runString = string.gsub(result, ".java", "")
	handle:close()
	os.execute("javac -d class " .. result)
	os.execute("java -cp class " .. runString)
end

return M
