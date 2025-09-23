-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
  local mainFileName = os.execute('grep -H "public static void main" *.java | cut -d: -f1')
	os.execute('javac -d class " + mainFileName)
	os.execute("java HelloWorld")
end

return M
