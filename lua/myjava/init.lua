-- lua/myjava/init.lua

local M = {}

function M.greeting()
	print("Hello World neu")
end

function M.compileAndnRun()
	os.execute("javac HelloWorld.java")
	os.execute("java HelloWorld")
end

return M
