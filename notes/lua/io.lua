
file = io.open("LuaTask.lua","r")

io.input(file)

print(io.read())
print(io.read())
print(io.read())
print(io.read())
print(io.read())



io.close(file)
