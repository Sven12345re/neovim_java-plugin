-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
  locale mainFileName = os.execute('grep -H "public static void main" *.java | cut -d: -f1')
	os.execute(mainFileName)
	os.execute("java HelloWorld")
end

return M
