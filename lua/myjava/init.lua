-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
	local text = "Lua rocks!"

	-- Terminalgröße holen
	local handle = io.popen("stty size", "r")
	local result = handle:read("*a")
	handle:close()

	local rows, cols = result:match("(%d+)%s+(%d+)")
	rows, cols = tonumber(rows), tonumber(cols)

	-- Berechnen wo Text hin soll
	local row = math.floor(rows / 3) -- etwas höher als Mitte
	local col = math.floor((cols - #text) / 2)

	-- Bildschirm löschen + schreiben
	io.write("\27[2J")
	io.write(string.format("\27[%d;%dH%s\n", row, col, text))

	local handle = io.popen('grep -H "public static void main" *.java | cut -d: -f1')
	local result = handle:read("*a") -- liest die gesamte Ausgabe
	local runString = string.gsub(result, ".java", "")
	handle:close()
	os.execute("javac -d class " .. result)
	os.execute("java -cp class " .. runString)
end

return M
